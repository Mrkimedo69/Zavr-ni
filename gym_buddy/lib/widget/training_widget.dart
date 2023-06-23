import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gym_buddy/model/training.dart';
import 'package:gym_buddy/page/edit_training_page.dart';
import 'package:gym_buddy/provider/trainings.dart';
import 'package:gym_buddy/utils.dart';
import 'package:provider/provider.dart';

class TrainingWidget extends StatelessWidget {
  final Training training;

  const TrainingWidget({
    super.key,
    required this.training,
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          actionPane: const SlidableDrawerActionPane(),
          key: Key(training.id),
          actions: [
            IconSlideAction(
              color: Colors.green,
              onTap: () => editTraining(context, training),
              caption: 'Edit',
              icon: Icons.edit,
            ),
          ],
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              onTap: () => deleteTraining(context, training),
              caption: 'Delete',
              icon: Icons.delete,
            ),
          ],
          child: buildTraining(context),
        ),
      );

  Widget buildTraining(BuildContext context) => GestureDetector(
        onTap: () => editTraining(context, training),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: training.isDone,
                onChanged: (_) {
                  final provider =
                      Provider.of<TrainingsProvider>(context, listen: false);
                  final isDone = provider.toggleTrainingStatus(training);

                  Utils.showSnackBar(context,
                      isDone ? 'Training done' : 'Training still in progress');
                },
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    training.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                    ),
                  ),
                  if (training.description.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: Text(
                        training.description,
                        style: const TextStyle(
                          fontSize: 20,
                          height: 1.5,
                        ),
                      ),
                    ),
                ],
              ))
            ],
          ),
        ),
      );

  void deleteTraining(BuildContext context, Training training) {
    final provider = Provider.of<TrainingsProvider>(context, listen: false);
    provider.removeTraining(training);

    Utils.showSnackBar(context, 'Deleted the training');
  }

  void editTraining(BuildContext context, Training training) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTrainingPage(training: training),
        ),
      );
}
