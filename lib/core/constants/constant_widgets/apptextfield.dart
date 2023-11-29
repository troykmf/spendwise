import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  final bool autoFocus;
  final bool obscureText;
  final bool autoCorrect;
  final Function(String)? onChnaged;
  final Function()? onTap;
  final TextStyle? style;
  final int? maxlines;
  final int? minlines;
  final int? maxLength;
  final Color? color;
  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.textInputType,
    required this.autoFocus,
    required this.obscureText,
    required this.autoCorrect,
    this.onChnaged,
    this.onTap,
    this.style,
    this.maxlines,
    this.minlines,
    this.maxLength,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      autofocus: autoFocus,
      autocorrect: autoCorrect,
      onChanged: onChnaged,
      maxLines: maxlines ?? 1,
      minLines: minlines,
      maxLength: maxLength,
      onTap: onTap,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
      ),
    );
  }
}

class AppCustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final bool autoFocus;
  final bool obscureText;
  final bool autoCorrect;
  final Function(String)? onChnaged;
  final Function()? onTap;
  final TextStyle? style;
  final int? maxlines;
  final int? minlines;
  final int? maxLength;
  const AppCustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.textInputType,
    required this.autoFocus,
    required this.obscureText,
    required this.autoCorrect,
    this.onChnaged,
    this.onTap,
    this.style,
    this.maxlines,
    this.minlines,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus,
      obscureText: obscureText,
      autocorrect: autoCorrect,
      maxLines: maxlines,
      minLines: minlines,
      maxLength: maxLength,
      keyboardType: textInputType,
      controller: controller,
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          // borderSide: BorderSide(color: Colors.grey.shade50),
        ),
        alignLabelWithHint: false,
        hintText: hintText,
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const AppButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 40.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: const Color.fromARGB(255, 4, 0, 247),
        ),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        )),
      ),
    );
  }
}
