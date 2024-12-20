import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor, textColor;
  const CustomButton({
    required this.text,
    required this.onPressed,
    this.buttonColor = Colors.blue,
    this.textColor = Colors.white,
    super.key,
  });
  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: textColor,
        ),
        child: Text(text),
      );
}
class CustomAlertDialog extends StatelessWidget {
  final String title, message, positiveText, negativeText;
  final VoidCallback onPositive, onNegative;
  const CustomAlertDialog({
    required this.title,
    required this.message,
    required this.positiveText,
    required this.negativeText,
    required this.onPositive,
    required this.onNegative,
    super.key,
  });
  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CustomButton(text: negativeText, onPressed: onNegative),
          CustomButton(text: positiveText, onPressed: onPositive),
        ],
      );
}
void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Example')),
          body: Center(
            child: CustomButton(
              text: 'Click Me',
              onPressed: () => print('Button Pressed'),
            ),
          ),
        ),
      );
}
