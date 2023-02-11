import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController =
      Get.put(TaskController()); //creating object from taskController
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime =DateFormat('HH:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('HH:mm a')
      .format(DateTime.now().add(Duration(minutes: 15)))
      .toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add Task',
                style: headingStyle,
              ),
              InputField(
                title: 'Title',
                note: 'Enter title here',
                controller: _titleController,
              ),
              InputField(
                title: 'Note',
                note: 'Enter note title here',
                controller: _noteController,
              ),
              InputField(
                title: 'Date',
                note: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                    onPressed: () {
                      _getDateFromUser();
                    },
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    )),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      note: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(true);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      note: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(false);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                  title: 'Remind',
                  note: '$_selectedRemind minutes early',
                  widget: Row(
                    children: [
                      DropdownButton(
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: Colors.blueGrey,
                        items: remindList
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(
                                  '$value',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                        style: subTitleStyle,
                        onChanged: (int? newValue) {
                          _selectedRemind = newValue!;
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        underline: Container(
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      )
                    ],
                  )),
              InputField(
                  title: 'Repeat',
                  note: _selectedRepeat,
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        items: repeatList
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(
                                  '$value',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                        style: subTitleStyle,
                        onChanged: (String? newValue) {
                          _selectedRepeat = newValue!;
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        underline: Container(
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      )
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPalette(),
                  MyButton(
                      label: 'Create Task',
                      onTap: () {
                        _validateDate();
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();

    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar('required', 'message',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: Icon(
            Icons.warning_amber_outlined,
            color: Colors.red,
          ));
    }
  }

  _addTaskToDb() async {
   try { int value = await _taskController.addTask(
      task: Task(
        title: _titleController.text,
        note: _noteController.text,
        isCompleted: 0,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        color: _selectedColor,
        remind:_selectedRemind,
        repeat: _selectedRepeat,
      ),
    );
    print('$value');}
       catch (e){
     print('error');
       }
  }

  Column _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: headingStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  child: _selectedColor == index
                      ? Icon(
                          Icons.done,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : orangeClr,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: primaryClr,
          )),
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
          radius: 20,
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  void _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    }
    else {
      print('');
    }
  }

   _getTimeFromUser( bool isStartTime) async {
    TimeOfDay? _pickedTime= await showTimePicker(
        context: context, initialTime:isStartTime
        ? TimeOfDay.fromDateTime(DateTime.now())
    : TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 15))) );
   String _formattedTime=_pickedTime!.format(context);
    if(isStartTime){
      setState(() {
        _startTime = _formattedTime;
      });
    }
   else if(!isStartTime){
      setState(() {
        _endTime = _formattedTime;
      });
    }

  }
}
