import 'package:flutter/material.dart';
import 'package:gym_buddy/provider/trainings.dart';
import 'package:gym_buddy/widget/training_widget.dart';
import 'package:provider/provider.dart';

class TrainingListWidget extends StatelessWidget {
  const TrainingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TrainingsProvider>(context);
    final trainings = provider.trainings;

    return trainings.isEmpty
        ? const Center(
            child: Text(
              'No trainings',
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
