import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:metropole/app/routes/api.routes.dart';
import 'package:metropole/app/routes/app.routes.dart';
import 'package:metropole/core/notifiers/user.notifier.dart';
import 'package:provider/provider.dart';
import 'widgets/fortune_wheel.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({
    Key? key,
  }) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  FortuneWheelController<int> fortuneWheelController = FortuneWheelController();
  FortuneWheelChild? currentWheelChild;
  int currentBalance = 0;

  @override
  void initState() {
    fortuneWheelController.addListener(() {
      if (fortuneWheelController.value == null) return;

      setState(() {
        currentWheelChild = fortuneWheelController.value;
      });

      if (fortuneWheelController.isAnimating) return;

      if (fortuneWheelController.shouldStartAnimation) return;

      setState(() {
        currentBalance += fortuneWheelController.value!.value;
      });
    });

    () async {
      final userNotifier = Provider.of<UserNotifier>(context, listen: false);
      setState(() {
        currentBalance = userNotifier.getBalance ?? 0;
      });
    }();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!fortuneWheelController.isAnimating) {
      final userNotifier = Provider.of<UserNotifier>(context, listen: false);
      userNotifier.updateUserBalance(
          balance: currentBalance, userEmail: userNotifier.getUserEmail!);
    }
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                      color:
                          currentBalance.isNegative ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    'Учурдагы упай: $currentBalance MPC',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(color: Colors.black87),
                const SizedBox(height: 16),
                Container(
                  height: 80,
                  width: 80,
                  child: currentWheelChild != null
                      ? currentWheelChild!.foreground
                      : Container(),
                ),
                const SizedBox(height: 16),
                SizedBox(
                    width: 350,
                    height: 350,
                    child: FortuneWheel<int>(
                      controller: fortuneWheelController,
                      children: [
                        _createFortuneWheelChild(-2),
                        _createFortuneWheelChild(10),
                        _createFortuneWheelChild(-3),
                        _createFortuneWheelChild(1),
                        _createFortuneWheelChild(-5),
                        _createFortuneWheelChild(3),
                        _createFortuneWheelChild(-10),
                        _createFortuneWheelChild(2),
                      ],
                    )),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () => fortuneWheelController.rotateTheWheel(),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Айлант',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  FortuneWheelChild<int> _createFortuneWheelChild(int value) {
    Color color = value.isNegative ? Colors.red : Colors.green;
    String verb = value.isNegative ? '-' : '+';
    int valueString = value.abs();

    return FortuneWheelChild(
        foreground: _getWheelContentCircle(color, '$verb$valueString MPС'),
        value: value);
  }

  Container _getWheelContentCircle(Color backgroundColor, String text) {
    return Container(
      width: 72,
      height: 72,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.8), width: 4)),
      child: Center(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
