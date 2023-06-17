part of 'task_repo.dart';

class TaskImpl extends TaskRepo {
  // Tastk
  final Map<String, dynamic> testTaskDB = {};
  final StreamController<String> _taskStreamController =
      StreamController.broadcast();

  @override
  Future removeTaskItem(String index) async {
    testTaskDB.remove(index);
    _taskStreamController.add(index);
  }

  @override
  Future<List<dynamic>> requestTskItemList() async {
    return testTaskDB.values.toList();
  }

  @override
  Future<dynamic> requestTaskItem(String index) async {
    return testTaskDB[index];
  }

  @override
  Stream<String> taskStream() {
    return _taskStreamController.stream;
  }

  @override
  Future updateTaskItem(String index, Map<String, dynamic> data) async {
    testTaskDB[index] = data;
    _taskStreamController.add(index);
  }

  // TaskTag
  final Map<String, dynamic> testLabelDB = {};
  final StreamController<String> _labelStreamController =
      StreamController.broadcast();

  @override
  Future reqeustLabel(String index) async {
    return testLabelDB[index];
  }

  @override
  Future<List> requestLabelList() async {
    return testLabelDB.values.toList();
  }

  @override
  Stream<String> labelStream() {
    return _labelStreamController.stream;
  }

  @override
  Future updateLabel(String index, Map<String, dynamic> data) async {
    testLabelDB[index] = data;
    _labelStreamController.add(index);
  }

  @override
  Future removeLabel(String index) async {
    testLabelDB.remove(index);
    _labelStreamController.add(index);
  }
}
