import 'package:flutter/material.dart';
import 'package:metropole/app/routes/app.routes.dart';
import 'package:provider/provider.dart';
import 'package:metropole/app/constants/app.assets.dart';
import 'package:metropole/app/constants/app.colors.dart';
import 'package:metropole/core/notifiers/product.notifier.dart';
import 'package:metropole/core/notifiers/theme.notifier.dart';
import 'package:metropole/core/notifiers/user.notifier.dart';
import 'package:metropole/presentation/screens/productScreen/widgets/brands.widget.dart';
import 'package:metropole/presentation/screens/productScreen/widgets/recommended.widget.dart';
import 'package:metropole/presentation/widgets/shimmer.effects.dart';
import 'package:metropole/presentation/widgets/custom.text.style.dart';
import 'package:metropole/presentation/widgets/dimensions.widget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;

    UserNotifier _userData = Provider.of<UserNotifier>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSizedBox2,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppColors.rawSienna,
                            AppColors.mediumPurple,
                            AppColors.fuchsiaPink,
                          ],
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.22,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 5, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Мини оюндар ',
                              style: CustomTextWidget.bodyTextB2(
                                  color: AppColors.creamColor),
                            ),
                            Text(
                              'Упай топтоо учун ойноо',
                              style: CustomTextWidget.bodyTextB3(
                                  color: AppColors.creamColor),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColors.creamColor,
                                    enableFeedback: true,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 2,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRouter.gameRoute);
                                  },
                                  child: Text(
                                    'Ойноо',
                                    style: CustomTextWidget.bodyText3(
                                      color: AppColors.mirage,
                                    ),
                                  ),
                                ),
                                hSizedBox2,
                                SizedBox(
                                  height: 115,
                                  width: 180,
                                  child: Image.asset(AppAssets.homeJordan),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    vSizedBox2,
                    const BrandWidget(),
                    vSizedBox2,
                    Text(
                      'Exclusive Shoes',
                      style: CustomTextWidget.bodyTextB2(
                        color:
                            themeFlag ? AppColors.creamColor : AppColors.mirage,
                      ),
                    ),
                    vSizedBox1,
                    SizedBox(
                      height: 210,
                      width: MediaQuery.of(context).size.width,
                      child: Consumer<ProductNotifier>(
                        builder: (context, notifier, _) {
                          return FutureBuilder(
                            future: notifier.fetchProducts(context: context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return ShimmerEffects.loadShimmer(
                                    context: context);
                              } else if (!snapshot.hasData) {
                                return Center(
                                  child: Text(
                                    'Some Error Occurred...',
                                    style: CustomTextWidget.bodyTextUltra(
                                      color: themeFlag
                                          ? AppColors.creamColor
                                          : AppColors.mirage,
                                    ),
                                  ),
                                );
                              } else {
                                var _snapshot = snapshot.data as List;
                                return productForYou(
                                  snapshot: _snapshot,
                                  themeFlag: themeFlag,
                                  context: context,
                                );
                              }
                            },
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
