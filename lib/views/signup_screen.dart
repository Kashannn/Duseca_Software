import 'package:flutter/material.dart';
import '../AppConstant/app_constant.dart';
import '../Resources/Components/custom_button.dart';
import '../Resources/Components/custom_container.dart';
import '../Resources/Components/custom_labeled_textField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/routes/routes_name.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 22.h),
            child: Column(
              children: [
                CustomContainer(
                  imagePath: 'assets/duseca_software_logo.jpeg',
                ),
                22.verticalSpace,
                Text(
                  'Sign Up',
                  style: kStyleBlack32600,
                ),
                16.verticalSpace,
                Text(
                  'Welcome to Duseca Software',
                  style: kStyleGrey14400,
                ),
                16.verticalSpace,
                CustomLabeledTextField(
                  labelStyle: kStyleBlack14400,
                  hintTextStyle: kStyleGrey16400,
                  controller: nameController,
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  passwordfield: false,
                ),
                11.verticalSpace,
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
                11.verticalSpace,
                CustomLabeledTextField(
                  labelStyle: kStyleBlack14400,
                  hintTextStyle: kStyleGrey16400,
                  controller: confirmPasswordController,
                  labelText: 'Confirm Password',
                  hintText: 'Re-enter your password',
                  passwordfield: true,
                ),
                // const Spacer(),
                66.verticalSpace,
                CustomButton(
                  text: 'Create Account',
                  onPressed: () async {},
                  color: kColorPrimary,
                ),
                11.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Already have an account?',
                      style: kStyleBlack14400,
                    ),
                    5.horizontalSpace,
                    GestureDetector(
                      onTap: () async {
                        Navigator.pushNamed(context, RoutesName.signInScreen);

                      },
                      child: Text(
                        'Sign In',
                        style: kStyleBlack14700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
