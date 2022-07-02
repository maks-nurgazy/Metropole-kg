import 'package:flutter/material.dart';
import 'package:metropole/app/constants/app.colors.dart';
import 'package:metropole/core/notifiers/theme.notifier.dart';
import 'package:provider/provider.dart';
import 'package:metropole/core/notifiers/user.notifier.dart';
import 'package:metropole/core/utils/snackbar.util.dart';
import 'package:metropole/presentation/widgets/custom.back.btn.dart';
import 'package:metropole/presentation/widgets/custom.text.field.dart';
import 'package:metropole/presentation/widgets/custom.text.style.dart';
import 'package:metropole/presentation/widgets/dimensions.widget.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);
    String patttern = r'(^(?:[+0]9)?[0-9]{10,15}$)';
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
        body: Column(
          children: [
            Row(
              children: [
                CustomBackPop(themeFlag: themeFlag),
                Text(
                  'Профилди өзгөрт',
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
                      textEditingController: addressController,
                      hintText: 'Дарек жаз',
                      validator: (val) => val!.isEmpty ? 'Дарек жаз' : null,
                    ),
                    vSizedBox3,
                    CustomTextField.customTextField(
                      textEditingController: numberController,
                      hintText: 'Номур жаз',
                      validator: (val) =>
                          !RegExp(patttern).hasMatch(val!) ? 'Номур жаз' : null,
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
                              .updateUserDetails(
                                  userEmail: userNotifier.getUserEmail!,
                                  userAddress: addressController.text,
                                  userPhoneNo: numberController.text,
                                  context: context)
                              .then((value) {
                            if (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackUtil.stylishSnackBar(
                                  text: 'Алмашты',
                                  context: context,
                                ),
                              );
                              Navigator.of(context).pop();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackUtil.stylishSnackBar(
                                  text:
                                      'Ката чыкты. Бир аздан кийин кайра аракет кылып көрүңүз...',
                                  context: context,
                                ),
                              );
                              Navigator.of(context).pop();
                            }
                          });
                        }
                      },
                      color: AppColors.rawSienna,
                      child: const Text(
                        'Жаңылоо',
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
