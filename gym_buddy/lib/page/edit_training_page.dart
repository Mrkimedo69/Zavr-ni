import 'package:flutter/material.dart';
import 'package:gym_buddy/model/training.dart';
import 'package:gym_buddy/provider/trainings.dart';
import 'package:gym_buddy/widget/training_form.dart';
import 'package:provider/provider.dart';

class EditTrainingPage extends StatefulWidget {
  final Training training;

  const EditTrainingPage({super.key, required this.training});

  @override
  State<EditTrainingPage> createState() => _EditTrainingPageState();
}

class _EditTrainingPageState extends State<EditTrainingPage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    title = widget.training.title;
    description = widget.training.description;
  }

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit Training'),
          actions: [
            IconButton(
              onPressed: () {
                final provider =
                    Provider.of<TrainingsProvider>(context, listen: false);
                provider.removeTraining(widget.training);
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: TrainingFormWidget(
              title: title,
              description: description,
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSavedTraining: saveTraining,
            ),
          ),
        ),
      );

  void saveTraining() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TrainingsProvider>(context, listen: false);

      provider.updateTraining(widget.training, title, description);

      Navigator.of(context).pop();
    }
  }
}
