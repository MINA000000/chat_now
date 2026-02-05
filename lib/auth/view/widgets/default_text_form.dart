import 'package:flutter/material.dart';
import 'package:chat_now/shared/app_theme.dart';

class DefaultTextForm extends StatefulWidget {
  const DefaultTextForm({
    super.key,
    required this.hint,
    required this.controller,
    this.validator,
    this.isPassword = false,
  });
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isPassword;

  @override
  State<DefaultTextForm> createState() => _DefaultTextFormState();
}

class _DefaultTextFormState extends State<DefaultTextForm> {
  late bool obsecure = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure,
      controller: widget.controller,
      style: TextStyle(color: AppTheme.black, fontSize: 16),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(color: AppTheme.greyColor, fontSize: 16),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  obsecure = !obsecure;
                  setState(() {});
                },
                icon: Icon(obsecure ? Icons.visibility : Icons.visibility_off),
              )
            : null,
      ),
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
