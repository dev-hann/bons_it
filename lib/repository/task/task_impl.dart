part of 'task_repo.dart';

class TaskImpl extends TaskRepo {
  // Tastk
  final Map<String, dynamic> testTodoFolderDB = {};
  final StreamController<String> _folderStreamController =
      StreamController.broadcast();

  @override
  Stream<String> folderStream() {
    return _folderStreamController.stream;
  }

  @override
  Future<List> requestTodoFolderList() async {
    return testTodoFolderDB.values.toList();
  }

  @override
  Future requestTodoFolder(String index) {
    return testTodoFolderDB[index];
  }

  @override
  Future updateTodoFolder(String index, Map<String, dynamic> map) async {
    testTodoFolderDB[index] = map;
    _folderStreamController.add(index);
  }

  @override
  Future removeTodoFolder(String index) async {
    testTodoFolderDB.remove(index);
    _folderStreamController.add(index);
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
