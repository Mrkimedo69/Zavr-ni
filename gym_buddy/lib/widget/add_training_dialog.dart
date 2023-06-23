import 'package:flutter/material.dart';
import 'package:gym_buddy/model/training.dart';
import 'package:gym_buddy/provider/trainings.dart';
import 'package:gym_buddy/widget/training_form.dart';
import 'package:provider/provider.dart';

class AddTrainingDialogWidget extends StatefulWidget {
  const AddTrainingDialogWidget({super.key});

  @override
  State<AddTrainingDialogWidget> createState() =>
      _AddTrainingDialogWidgetState();
}

class _AddTrainingDialogWidgetState extends State<AddTrainingDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Training',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TrainingFormWidget(
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() => this.description = description),
                onSavedTraining: addTraining,
              ),
            ],
          ),
        ),
      );

  void addTraining() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final training = Training(
        createdTime: DateTime.now(),
        title: title,
        id: DateTime.now().toString(),
        description: description,
      );
      final provider = Provider.of<TrainingsProvider>(context, listen: false);
      provider.addTraining(training);
      Navigator.of(context).pop();
    }
  }
}
