import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.title,
    required this.onSave,
  });

  final String title;
  final void Function(String value) onSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            labelText: title,
            border: const OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return "This field is required";
            }
            return null;
          },
          onSaved: (newValue) => onSave(newValue!),
        ),
        const SizedBox(height: 12)
      ],
    );
  }
}
