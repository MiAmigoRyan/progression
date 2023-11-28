import 'package:freezed_annotation/freezed_annotation.dart';

part 'tasks.freezed.dart';

@freezed
class Task with _$Task{
  const factory Task({

   String? description,
   int? sets,
   int? reps,
   Duration? duration,
  }) = _Task;
}

