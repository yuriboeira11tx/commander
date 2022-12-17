import 'package:commander/utils/styles.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: 120,
              height: 120,
              child: Image.asset("assets/logo/logotipo.jpg"),
            ),
          ),
          const CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation(colorPrimarySwatch),
            strokeWidth: 2.0,
          ),
        ],
      ),
    );
  }
}
