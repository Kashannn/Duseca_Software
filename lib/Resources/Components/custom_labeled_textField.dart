import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../AppConstant/app_constant.dart';
class CustomLabeledTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool passwordfield;
  final TextStyle labelStyle;
  final TextStyle hintTextStyle;
  final String? startIcon;

  const CustomLabeledTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.passwordfield,
    required this.labelStyle,
    required this.hintTextStyle,
    required this.hintText,
    this.startIcon,
  }) : super(key: key);

  @override
  State<CustomLabeledTextField> createState() => _CustomLabeledTextFieldState();
}

class _CustomLabeledTextFieldState extends State<CustomLabeledTextField> {
  bool passwordVisible = true;
  FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.passwordfield
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: widget.labelStyle,
        ),
        11.verticalSpace,
        Container(
          width: 345.w,
          height: 60.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: _isFocused ? kColorPrimary : Colors.transparent,
            ),
            color: kColorPrimary2,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  style: widget.hintTextStyle,
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                    hintStyle: widget.hintTextStyle,
                    hintText: widget.hintText,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 18.h),
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(passwordVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility),
                color: kColorGrey124,
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    )
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: widget.labelStyle,
        ),
        11.verticalSpace,
        Container(
          width: 345.w,
          height: 60.h,
          padding: EdgeInsets.symmetric(
              horizontal: widget.startIcon != null ? 1.w : 20.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: _isFocused ? kColorPrimary : Colors.transparent,
            ),
            color: kColorPrimary2,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Row(
            children: [
              if (widget.startIcon != null)
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Image.asset(
                    widget.startIcon!,
                    color: kColorBlack,
                    width: 17.w,
                    height: 17.h,
                  ),
                  onPressed: () {},
                ),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  style: widget.hintTextStyle,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: widget.hintTextStyle,
                    contentPadding: EdgeInsets.symmetric(vertical: 18.h),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
