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
}
