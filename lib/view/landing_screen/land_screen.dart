import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ab_test/view/landing_screen/widgets/email_widget.dart';

import '../../common_widgets/animated_image.dart';
import '../../common_widgets/input_field.dart';

class LandScreen extends StatelessWidget {
  static const routeName = '/LandScreen';

  const LandScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedImage(
            imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/egymarocapp.appspot.com/o/moods%2F270588434_470486377840179_4689152206490314599_n.jpg?alt=media&token=2e32645e-b38a-4f83-b85c-5b6b9997864c',
          ),
          Center(
            child: BlurryContainer(
                blur: 5,
                width: 250,
                height: 250,
                elevation: 5,
                color: Colors.transparent,
                padding: EdgeInsets.all(8),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: EmailWidget(),
            ),
          )
        ],
      ),
    );
  }
}
