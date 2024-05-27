import 'package:flutter/material.dart';
import 'package:plusclouds/constants.dart';

class APISuccessDialog extends StatelessWidget {
  const APISuccessDialog({super.key, required this.title, required this.description, this.onPressed});
  final String title;
  final String description;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            apiSuccessAnimation,
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Color(0xFF201E1E)),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                FocusScope.of(context).unfocus();
                if (onPressed != null) {
                  onPressed!();
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "That's Hit!",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

void showAPISuccessDialog(BuildContext context, String title, String description, {Function? onpress}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return APISuccessDialog(
        title: title,
        description: description,
        onPressed: onpress,
      );
    },
  );
}
