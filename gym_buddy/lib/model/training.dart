import 'package:gym_buddy/utils.dart';

class TrainingField {
  static const createdTime = 'createdTIme';
}

class Training {
  DateTime createdTime;
  String title;
  String id;
  String description;
  bool isDone;

  Training({
    required this.createdTime,
    required this.title,
    this.description = '',
    this.id = '',
    this.isDone = false,
  });

  static Training fromJson(Map<String, dynamic> json) => Training(
      createdTime: Utils.toDateToTime(json['createdTime']),
      title: json['title'],
      description: json['description'],
      id: json['id'],
      isDone: json['isDone']);

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'title': title,
        'id': id,
        'description': description,
        'isDone': isDone
      };
}
