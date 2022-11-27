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
              child: Image.network(
                  "https://instagram.fsqx1-1.fna.fbcdn.net/v/t51.2885-15/270400003_334289841638577_3655333745000633808_n.jpg?stp=dst-jpg_e35&_nc_ht=instagram.fsqx1-1.fna.fbcdn.net&_nc_cat=109&_nc_ohc=oXb0hbDRC6UAX-v_dKz&edm=ALQROFkBAAAA&ccb=7-5&ig_cache_key=Mjc0MDQ1MzYwNjUyMjY5MDYxMA%3D%3D.2-ccb7-5&oh=00_AfBnLbQ-aBk-Ooa0YDnu9P4YRXDiescNslYzvoFD0e9pfg&oe=6388158F&_nc_sid=30a2ef"),
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
