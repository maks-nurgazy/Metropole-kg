import 'package:flutter/material.dart';
import 'package:metropole/app/constants/app.colors.dart';
import 'package:metropole/app/constants/app.fonts.dart';
import 'package:metropole/presentation/widgets/dimensions.widget.dart';

Widget welcomeTextLogin({required bool themeFlag}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      vSizedBox5,
      vSizedBox1,
      Padding(
        padding: const EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 2.0),
        child: RichText(
          text: TextSpan(
            text: 'METROPOLE KG',
            style: TextStyle(
              color: themeFlag ? AppColors.creamColor : AppColors.mirage,
              fontWeight: FontWeight.w900,
              fontFamily: AppFonts.contax,
              fontSize: 40.0,
            ),
          ),
        ),
      ),
      vSizedBox2,
      Padding(
        padding: const EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 2.0),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Аккаунтка кирүү ',
                    style: TextStyle(
                      color:
                          themeFlag ? AppColors.creamColor : AppColors.mirage,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                  TextSpan(
                    text: 'үчүн ',
                    style: TextStyle(
                      color:
                          themeFlag ? AppColors.creamColor : AppColors.mirage,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: 'боштукту толтуруңуз ! ',
                    style: TextStyle(
                      color:
                          themeFlag ? AppColors.creamColor : AppColors.mirage,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
