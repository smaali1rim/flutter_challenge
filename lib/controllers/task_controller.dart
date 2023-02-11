import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/models/task.dart';

//the link between ui and the database
class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[
  ].obs;

  Future<int> addTask({ Task? task}) {
    return DBHelper.insert(task!);
  }

  //get data from database
 Future<void> getTasks() async {
    //from database to tasklist
    //tasks is json data
    final List<Map<String, dynamic>> tasks = await DBHelper.Query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  deleteTasks(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }
 void deleteAllTasks() async{
    await DBHelper.deleteAll();
  }

  void markTaskCompleted(int id) async {
    await DBHelper.Update(id);
    getTasks();
  }
}
