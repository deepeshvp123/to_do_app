
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/models/modeltask.dart';
import 'package:to_do_app/views/task/taskview.dart';
import 'package:to_do_app/widgets/taskwidget.dart';

class HiveDB {
  static const boxName = "modeltaskbox";
  final Box<modeltask> box = Hive.box<modeltask>(boxName);

  /// Add new Task
  Future<void> addTask({required modeltask task}) async {
    await box.put(task.id, task);
  }

  /// Show task
  Future<modeltask?> getTask({required String id}) async {
    return box.get(id);
  }

  /// Update task
  Future<void> updateTask({required modeltask task}) async {
    await task.save();
  }

  /// Delete task
  Future<void> dalateTask({required modeltask task}) async {
    await task.delete();
  }

  ValueListenable<Box<modeltask>> listenToTask() {
    return box.listenable();
  }
}