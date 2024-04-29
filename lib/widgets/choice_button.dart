import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  const ChoiceButton({
    Key? key,
    required this.onClick,
    required this.title,
    this.backgroundImage,
  }) : super(key: key);

  final void Function() onClick;
  final String title;
  final String? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (backgroundImage != null)
          Positioned.fill(
            child: Image.asset(
              backgroundImage!,
              fit: BoxFit.cover,
            ),
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 270,
              child: ElevatedButton(
                onPressed: onClick,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 120, 8, 200), // Button color
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: Text(title),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ],
    );
  }
}
