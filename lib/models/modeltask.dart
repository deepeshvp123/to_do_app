import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'modeltask.g.dart';

@HiveType(typeId: 0)
class modeltask extends HiveObject {
  // id
  @HiveField(0)
  String id;
  // TITLE
  @HiveField(1)
  String title;
  @HiveField(2)
  // SUBTITLE
  String subtitle;
  @HiveField(3)
  // CREATE TIME 
  DateTime createdattime;
  @HiveField(4)
  // CREATED DATE 
  DateTime createdatdate;
  @HiveField(5)
  // IS COMPLETED 
  bool iscompleted;
  modeltask({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.createdattime,
    required this.createdatdate,
    required this.iscompleted,
  });
  //create new model task
  factory modeltask.create({
    required String? title,
    required String? subtitle,
    DateTime? createdattime,
    DateTime? createdatdate,
  }) =>
      modeltask(
          id: Uuid().v1(),
          title: title ?? "",
          subtitle: subtitle ?? "",
          createdattime: createdattime ?? DateTime.now(),
          createdatdate: createdatdate ?? DateTime.now(),
          iscompleted: false);
}
