import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog(
      {super.key,
      required this.title,
      this.content,
      this.primaryButtonText,
      this.secondaryButtonText,
      required this.onPrimaryButtonClicked,
      this.onSecondaryButtonClicked});

  final String title;
  final String? content;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback onPrimaryButtonClicked;
  final VoidCallback? onSecondaryButtonClicked;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: (content != null) ? Text('$content') : null,
      actions: [
        TextButton(
          onPressed: () {
            if (onSecondaryButtonClicked != null) {
              onSecondaryButtonClicked!();
            }
            Navigator.pop(context);
          },
          child: (secondaryButtonText != null)
              ? Text(secondaryButtonText!)
              : const Text('Cancelar'),
        ),
        TextButton(
          onPressed: (){
            onPrimaryButtonClicked();
            Navigator.pop(context);
          },
          child: (primaryButtonText != null)
              ? Text(primaryButtonText!)
              : const Text('Ok'),
        ),
      ],
    );
  }
}
