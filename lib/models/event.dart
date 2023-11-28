import 'package:coach_flutter/models/task.dart';

class Event {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final List<Task> tasks;

const Event ({
  required this.title,
  required this.description,
  required this.from,
  required this.to,
  required this.tasks,

});
}