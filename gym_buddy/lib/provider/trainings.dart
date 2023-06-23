import 'package:flutter/cupertino.dart';
import 'package:gym_buddy/api/firebase_api.dart';
import 'package:gym_buddy/model/training.dart';

class TrainingsProvider extends ChangeNotifier {
  late List<Training> _trainings = [];

  List<Training> get trainings =>
      _trainings.where((training) => training.isDone == false).toList();
  List<Training> get doneTrainings =>
      _trainings.where((training) => training.isDone == true).toList();

  void setTrainings(List<Training> trainings) =>
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          _trainings = trainings;
          notifyListeners();
        },
      );

  void addTraining(Training training) => FirebaseApi.createTraining(training);

  void removeTraining(Training training) =>
      FirebaseApi.deleteTraining(training);

  bool toggleTrainingStatus(Training training) {
    training.isDone = !training.isDone;

    FirebaseApi.updateTraining(training);

    return training.isDone;
  }

  void updateTraining(Training training, String title, String description) {
    training.title = title;
    training.description = description;

    FirebaseApi.updateTraining(training);
  }
}
