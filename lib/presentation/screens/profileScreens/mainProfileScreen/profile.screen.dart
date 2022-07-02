import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:metropole/app/constants/app.colors.dart';
import 'package:metropole/app/constants/app.keys.dart';
import 'package:metropole/app/routes/app.routes.dart';
import 'package:metropole/core/notifiers/theme.notifier.dart';
import 'package:provider/provider.dart';
import 'package:metropole/core/notifiers/user.notifier.dart';
import 'package:metropole/core/utils/snackbar.util.dart';
import 'package:metropole/presentation/widgets/custom.back.btn.dart';
import 'package:metropole/presentation/widgets/custom.text.style.dart';
import 'package:metropole/presentation/widgets/dimensions.widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    final userNotifier = Provider.of<UserNotifier>(context, listen: false);

    var themeFlag = _themeNotifier.darkTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
        body: Column(
          children: [
            Row(
              children: [
                CustomBackButton(
                  route: AppRouter.homeRoute,
                  themeFlag: themeFlag,
                ),
                Text(
                  'Профиль',
                  style: CustomTextWidget.bodyTextB2(
                    color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  ),
                ),
              ],
            ),
            vSizedBox1,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _createAccountInformation(
                    context: context,
                    themeFlag: themeFlag,
                  ),
                  const SizedBox(height: 10),
                  Consumer<UserNotifier>(builder: (context, notifier, _) {
                    return FutureBuilder(
                        future: notifier.getUserDetails(
                            userEmail: userNotifier.userEmail!,
                            context: context),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print('printing balance');
                            print(snapshot.data);
                          }

                          return Card(
                            child: const ListTile(
                              title: Text("Топтолгон упай"),
                              trailing: Text(
                                '20',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            elevation: 8,
                            shadowColor: Colors.green,
                            // margin: const EdgeInsets.all(20),
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.green, width: 1)),
                          );
                        });
                  }),
                  const SizedBox(height: 20),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRouter.editProfileRoute);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 18, 0, 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Маалыматты толуктоо',
                            style: TextStyle(
                              fontSize: 15,
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRouter.changePassRoute);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 18, 0, 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Сыр сөздү өзгөрт',
                            style: TextStyle(
                              fontSize: 15,
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRouter.appSettingsRoute);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 18, 0, 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Жөндөөлөр',
                            style: TextStyle(
                              fontSize: 15,
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        DeleteCache.deleteKey(AppKeys.userData)
                            .whenComplete(() {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRouter.loginRoute);
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.power_settings_new,
                            size: 20,
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Аккаунттан чыгуу',
                            style: TextStyle(
                              fontSize: 15,
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAccountInformation({
    required BuildContext context,
    required bool themeFlag,
  }) {
    final userNotifier = Provider.of<UserNotifier>(context, listen: false);
    var userName = userNotifier.getUserName ?? 'Wait';
    final double profilePictureSize = MediaQuery.of(context).size.width / 4;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: profilePictureSize,
            height: profilePictureSize,
            child: GestureDetector(
              onTap: () {
                if (userName == 'Wait') {
                  SnackUtil.stylishSnackBar(
                      text: 'Session Timeout', context: context);
                  Navigator.of(context)
                      .pushReplacementNamed(AppRouter.loginRoute);
                  DeleteCache.deleteKey(AppKeys.userData);
                } else {
                  Navigator.of(context).pushNamed(AppRouter.accountInfo);
                }
              },
              child: CircleAvatar(
                backgroundColor:
                    themeFlag ? AppColors.creamColor : AppColors.mirage,
                radius: profilePictureSize - 4,
                child: Hero(
                  tag: 'profilePicture',
                  child: ClipOval(
                    child: SvgPicture.network(
                      'https://avatars.dicebear.com/api/big-smile/$userName.svg',
                      semanticsLabel: 'A shark?!',
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    if (userName == 'Wait') {
                      SnackUtil.stylishSnackBar(
                          text: 'Session Timeout', context: context);
                      Navigator.of(context)
                          .pushReplacementNamed(AppRouter.loginRoute);
                      DeleteCache.deleteKey(AppKeys.userData);
                    } else {
                      Navigator.of(context).pushNamed(AppRouter.accountInfo);
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        'Жеке маалымат',
                        style: TextStyle(
                          fontSize: 14,
                          color: themeFlag
                              ? AppColors.creamColor
                              : AppColors.mirage,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 20,
                        color:
                            themeFlag ? AppColors.creamColor : AppColors.mirage,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
