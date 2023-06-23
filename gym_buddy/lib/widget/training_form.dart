import 'package:flutter/material.dart';

class TrainingFormWidget extends StatelessWidget {
  const TrainingFormWidget({
    super.key,
    this.title = '',
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onSavedTraining,
  });

  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTraining;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            const SizedBox(
              height: 8,
            ),
            buildDescription(),
            const SizedBox(
              height: 32,
            ),
            buildButton(),
          ],
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        onChanged: onChangedTitle,
        validator: (title) {
          if (title != null) {
            if (title.isEmpty) {
              return 'Title field can not be empty';
            }
          }
          return null;
        },
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Title',
        ),
      );
  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        onChanged: onChangedDescription,
        validator: (description) {
          if (description != null) {
            if (description.isEmpty) {
              return 'Description field can not be empty';
            }
          }
          return null;
        },
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Description',
        ),
      );
  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: onSavedTraining,
          child: const Text('Save'),
        ),
      );
}
