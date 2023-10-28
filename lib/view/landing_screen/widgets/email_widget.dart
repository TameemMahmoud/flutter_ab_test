import 'package:flutter/material.dart';
import 'package:flutter_ab_test/common_widgets/staduim_button.dart';
import 'package:flutter_ab_test/utils/helper/hive_helper.dart';
import 'package:flutter_ab_test/view/home_screen/home_screen.dart';

import '../../../common_widgets/input_field.dart';

class EmailWidget extends StatelessWidget {
  EmailWidget({super.key});

  final TextEditingController emailController = TextEditingController();
final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyInputFiled(
            controller: emailController,
            hint: 'Email',
            label: 'Email Address',
            inputIcon: Icons.alternate_email,
            validate: (value) {
              if (value!.isEmpty) {
                return 'Please, enter your email';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 17,
          ),
          StadiumButton(
            title: 'Continue',
            fct: () {
              if(_formKey.currentState!.validate()){
                HiveHelper.setUserEmail(emailController.text);
                Navigator.pushNamed(context, HomeScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }
}
