import 'package:chat_now/shared/app_theme.dart';
import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
  const DefaultElevatedButton({super.key, required this.onPress, required this.text});
  final VoidCallback onPress;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primary,
        fixedSize: Size(255, 52),
      ),
      onPressed: onPress,
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: AppTheme.whiteColor),
      ),
    );
  }
}
