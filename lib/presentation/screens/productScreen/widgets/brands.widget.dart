import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:metropole/app/constants/app.assets.dart';
import 'package:metropole/app/constants/app.colors.dart';
import 'package:metropole/app/routes/app.routes.dart';
import 'package:metropole/core/notifiers/theme.notifier.dart';
import 'package:metropole/presentation/screens/categoryScreen/category.screen.dart';
import 'package:metropole/presentation/widgets/custom.text.style.dart';
import 'package:metropole/presentation/widgets/dimensions.widget.dart';

class BrandWidget extends StatelessWidget {
  const BrandWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;

    List<String> _categories = [
      "Jordan's",
      "Adidas",
      "Puma",
      "Reebok",
      "Nike",
    ];
    List<String> _categoriesImages = [
      AppAssets.brandJordan,
      AppAssets.brandAdidas,
      AppAssets.brandPuma,
      AppAssets.brandReebok,
      AppAssets.brandNike
    ];

    showBrands(String text, String images) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRouter.categoryRoute,
            arguments: CategoryScreenArgs(categoryName: text),
          );
        },
        child: SizedBox(
          height: 180,
          width: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.25,
                child: Image.network(images),
              ),
              vSizedBox1,
              Text(
                text,
                style: CustomTextWidget.bodyText2(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                ),
              )
            ],
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Бренддер',
          style: CustomTextWidget.bodyTextB2(
            color: themeFlag ? AppColors.creamColor : AppColors.mirage,
          ),
        ),
        vSizedBox2,
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.20,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: false,
            scrollDirection: Axis.horizontal,
            physics: const ScrollPhysics(),
            itemCount: _categories.length,
            itemBuilder: (BuildContext context, int index) {
              return showBrands(
                _categories[index],
                _categoriesImages[index],
              );
            },
          ),
        )
      ],
    );
  }
}
