import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
@HiveType(typeId: 0)
class TaskModel with _$TaskModel {
  const factory TaskModel({
    @HiveField(0) required int id,
    @HiveField(1) required String title,
    @HiveField(2) required String comment,
    @HiveField(3) required bool completed,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
}