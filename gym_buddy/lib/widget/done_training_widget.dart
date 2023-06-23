import 'package:flutter/material.dart';
import 'package:gym_buddy/provider/trainings.dart';
import 'package:gym_buddy/widget/training_widget.dart';
import 'package:provider/provider.dart';

class DoneTraining extends StatelessWidget {
  const DoneTraining({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TrainingsProvider>(context);
    final trainings = provider.doneTrainings;

    return trainings.isEmpty
        ? const Center(
            child: Text(
              'No completed training',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(
              height: 8,
            ),
            itemCount: trainings.length,
            itemBuilder: (context, index) {
              final training = trainings[index];
              return TrainingWidget(training: training);
            },
          );
  }
}
