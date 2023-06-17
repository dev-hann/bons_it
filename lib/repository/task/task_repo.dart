import 'dart:async';

part 'task_impl.dart';

abstract class TaskRepo {
  // Task
  Stream<String> taskStream();

  Future<dynamic> requestTaskItem(String index);

  Future<List<dynamic>> requestTskItemList();

  Future updateTaskItem(String index, Map<String, dynamic> data);

  Future removeTaskItem(String index);

  // Label
  Stream<String> labelStream();

  Future<dynamic> reqeustLabel(String index);

  Future<List<dynamic>> requestLabelList();

  Future updateLabel(String index, Map<String, dynamic> data);

  Future removeLabel(String index);
}
