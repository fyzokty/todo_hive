// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todo/model/app_enum.dart';

class ReminderModel {
  final int id;
  final String title;
  final String text;
  final List<String> imgPaths;
  final bool isCompleted;
  final bool isDeleted;
  final bool isFavorited;
  final TaskColor color;
  final DateTime? alertDate;
  final DateTime createDate;

  ReminderModel({
    required this.id,
    required this.title,
    required this.text,
    required this.imgPaths,
    this.isCompleted = false,
    this.isDeleted = false,
    this.isFavorited = false,
    this.color = TaskColor.DEFAULT,
    this.alertDate,
    required this.createDate,
  });
}
