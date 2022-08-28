import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final primaryColorLight = const Color(0xFFD8E0ED);
  final primaryColorDark = const Color(0xFF2E3243);

  var isPressed = false;
  var isDark = false;

  Widget dayNight() {
    final positionShadow = isDark ? -40.0 : -210.0;

    return Stack(
      children: [
        Container(
          width: 210,
          height: 210,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: isDark
                  ? [
                      const Color(0xFF30218F),
                      const Color(0xFF8D81DD),
                    ]
                  : [
                      const Color(0xFFFFCC81),
                      const Color(0xFFFF6E30),
                    ],
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          top: positionShadow,
          right: positionShadow,
          child: Container(
            width: 210,
            height: 210,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? primaryColorDark : primaryColorLight,
            ),
          ),
        ),
      ],
    );
  }

  Widget centerText() {
    return Text(
      isDark ? 'Good\nNight' : 'Good\nMorning',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 44,
        fontWeight: FontWeight.bold,
        color: isDark ? primaryColorLight : primaryColorDark,
      ),
    );
  }

  Widget powerButton() {
    return Listener(
      onPointerDown: (_) => setState(() {
        isPressed = true;
      }),
      onPointerUp: (_) => setState(() {
        isPressed = false;
        isDark = !isDark;

        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          ),
        );
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? primaryColorDark : primaryColorLight,
          boxShadow: [
            BoxShadow(
              offset: const Offset(-5, 5),
              blurRadius: 10,
              color: isDark ? const Color(0xFF121625) : const Color(0xFFA5B7D6),
              inset: isPressed,
            ),
            BoxShadow(
              offset: const Offset(5, -5),
              blurRadius: 10,
              color: isDark ? const Color(0x4D9DA7CF) : Colors.white70,
              inset: isPressed,
            ),
          ],
        ),
        child: Icon(
          Icons.power_settings_new,
          size: 48,
          color: isDark ? primaryColorLight : primaryColorDark,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? primaryColorDark : primaryColorLight,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            dayNight(),
            const SizedBox(height: 36),
            centerText(),
            const SizedBox(height: 120),
            powerButton(),
          ],
        ),
      ),
    );
  }
}
