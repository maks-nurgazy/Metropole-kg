import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:metropole/app/constants/app.colors.dart';
import 'package:metropole/core/notifiers/theme.notifier.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Карта менен төлөө мүмкүнчүлүгү толук ишке кирип баштаганда кошулат',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
