import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../AppConstant/app_constant.dart';
import '../Resources/Components/custom_button.dart';
import '../Resources/Components/custom_container.dart';
import '../Resources/Components/custom_labeled_textField.dart';
import '../utils/routes/routes_name.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 24.w),
          child: Column(
            children: [
              CustomContainer(imagePath: 'assets/duseca_software_logo.jpeg'),
              20.verticalSpace,
              Text(
                'Sign In',
                style: kStyleBlack32600,
              ),
              16.verticalSpace,
              Text(
                'Welcome back to Duseca Software',
                style: kStyleGrey14400,
              ),
              26.verticalSpace,
              CustomLabeledTextField(
                labelStyle: kStyleBlack14400,
                hintTextStyle: kStyleGrey16400,
                controller: emailController,
                labelText: 'Email',
                hintText: 'Enter your email',
                passwordfield: false,
              ),
              11.verticalSpace,
              CustomLabeledTextField(
                labelStyle: kStyleBlack14400,
                hintTextStyle: kStyleGrey16400,
                controller: passwordController,
                labelText: 'Password',
                hintText: 'Enter your password',
                passwordfield: true,
              ),
              24.verticalSpace,
              CustomButton(
                  text: 'Login', onPressed: () {}, color: kColorPrimary),
              21.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: kStyleBlack14400,
                  ),
                  5.horizontalSpace,
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.signUpScreen);
                    },
                    child: Text(
                      'Sign Up',
                      style: kStyleBlack14700,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
