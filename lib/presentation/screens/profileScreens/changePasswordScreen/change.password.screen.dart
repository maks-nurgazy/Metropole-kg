import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:metropole/app/constants/app.colors.dart';
import 'package:metropole/app/constants/app.keys.dart';
import 'package:metropole/app/routes/app.routes.dart';
import 'package:metropole/core/notifiers/theme.notifier.dart';
import 'package:provider/provider.dart';
import 'package:metropole/core/notifiers/user.notifier.dart';
import 'package:metropole/core/utils/snackbar.util.dart';
import 'package:metropole/presentation/widgets/custom.back.btn.dart';
import 'package:metropole/presentation/widgets/custom.text.field.dart';
import 'package:metropole/presentation/widgets/custom.text.style.dart';
import 'package:metropole/presentation/widgets/dimensions.widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
        body: Column(
          children: [
            Row(
              children: [
                CustomBackPop(themeFlag: themeFlag),
                Text(
                  'Сыр сөздү алмаштыруу',
                  style: CustomTextWidget.bodyTextB2(
                    color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  ),
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(35.0, 45.0, 35.0, 2.0),
                child: Column(
                  children: [
                    CustomTextField.customTextField(
                      textEditingController: oldPassController,
                      hintText: 'Эски сыр сөздү жаз',
                      validator: (val) =>
                          val!.isEmpty ? 'Эски сыр сөздү жаз' : null,
                    ),
                    vSizedBox3,
                    CustomTextField.customTextField(
                      textEditingController: newPassController,
                      hintText: 'Жаңы сыр сөз жаз',
                      validator: (val) =>
                          val!.isEmpty ? 'Жаңы сыр сөз жаз' : null,
                    ),
                    vSizedBox3,
                    MaterialButton(
                      height: MediaQuery.of(context).size.height * 0.05,
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          userNotifier
                              .changePassword(
                                  userEmail: userNotifier.getUserEmail!,
                                  oluserpassword: oldPassController.text,
                                  newuserpassword: newPassController.text,
                                  context: context)
                              .then((value) {
                            if (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackUtil.stylishSnackBar(
                                    text:
                                        'Сыр сөз алмашты. Кайрадан кириңиз...',
                                    context: context),
                              );
                              DeleteCache.deleteKey(AppKeys.userData)
                                  .whenComplete(() {
                                Navigator.of(context)
                                    .pushReplacementNamed(AppRouter.loginRoute);
                              });
                            }
                            if (!value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackUtil.stylishSnackBar(
                                    text: 'Ката', context: context),
                              );
                            }
                          });
                        }
                      },
                      color: AppColors.rawSienna,
                      child: const Text(
                        'Өзгөрт',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
