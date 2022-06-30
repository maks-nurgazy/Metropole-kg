import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:metropole/app/constants/app.colors.dart';
import 'package:metropole/core/notifiers/theme.notifier.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: const Center(
        child: Text('Оюн экраны'),
      ),
    );
  }
}
