import 'package:flutter/cupertino.dart';
import 'package:gym_buddy/model/training.dart';

class TrainingsProvider extends ChangeNotifier {
  final List<Training> _trainings = [
    Training(
      createdTime: DateTime.now(),
      title: 'Chest',
      description: '''
      - Bench
      - Flys
      - Incline Bench
      - Push Ups''',
    ),
    Training(
      createdTime: DateTime.now(),
      title: 'Legs',
      description: '''
      - Squat
      - Leg Press
      - RDLs
      - Leg Extensions
      ''',
    ),
    Training(
      createdTime: DateTime.now(),
      title: 'Back',
      description: '''
      - DeadLift
      - Rows
      - Pull Ups
      ''',
    ),
  ];

  List<Training> get trainings =>
      _trainings.where((training) => training.isDone == false).toList();
  List<Training> get doneTrainings =>
      _trainings.where((training) => training.isDone == true).toList();

  void addTraining(Training training) {
    _trainings.add(training);

    notifyListeners();
  }

  void removeTraining(Training training) {
    _trainings.remove(training);

    notifyListeners();
  }

  bool toggleTrainingStatus(Training training) {
    training.isDone = !training.isDone;

    notifyListeners();

    return training.isDone;
  }

  void updateTraining(Training training, String title, String description) {
    training.title = title;
    training.description = description;

    notifyListeners();
  }
}
