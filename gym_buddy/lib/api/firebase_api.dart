import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_buddy/model/training.dart';
import 'package:gym_buddy/utils.dart';

class FirebaseApi {
  static Future<String> createTraining(Training training) async {
    final docTraining = FirebaseFirestore.instance.collection('training').doc();

    training.id = docTraining.id;
    await docTraining.set(training.toJson());

    return docTraining.id;
  }

  static Stream<List<Training>> readTraining() => FirebaseFirestore.instance
      .collection('training')
      .orderBy(TrainingField.createdTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(Training.fromJson));

  static Future updateTraining(Training training) async {
    final docTraining =
        FirebaseFirestore.instance.collection('training').doc(training.id);

    await docTraining.update(training.toJson());
  }

  static Future deleteTraining(Training training) async {
    final docTraining =
        FirebaseFirestore.instance.collection('training').doc(training.id);

    await docTraining.delete();
  }
}
