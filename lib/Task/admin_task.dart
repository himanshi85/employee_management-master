import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:staff_management/json.dart';
import 'package:staff_management/main.dart';

class AdminTaskPage extends StatefulWidget {
  const AdminTaskPage({Key? key}) : super(key: key);

  @override
  State<AdminTaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<AdminTaskPage> {
  bool isSeeMorePress = false;
  int editEmployeeIndex = -1;
  String? assignEmployee;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewTask();
  }

  List<bool> assign = [];
  bool isAddTask = false;
  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Color(0x000000),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isAddTask = !isAddTask;
                  print(HomePage.viewUserJson.user!.length);
                });
              },
              child: Card(
                child: SizedBox(
                  height: isAddTask ? 115 : 50,
                  width: double.infinity,
                  child: isAddTask
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CupertinoTextField(
                                      onSubmitted: (value) {
                                        setState(() {
                                          if (assignEmployee != null &&
                                              taskController.text.isNotEmpty) {
                                            addTask(
                                                task: taskController.text,
                                                employee: assignEmployee!);
                                            isAddTask = false;
                                          } else {
                                            if (taskController.text.isEmpty) {
                                              showCupertinoDialog(
                                                context: context,
                                                builder: (context) {
                                                  return dialog(
                                                      title:
                                                          'Please Fill Task');
                                                },
                                              );
                                            } else {
                                              showCupertinoDialog(
                                                context: context,
                                                builder: (context) {
                                                  return dialog(
                                                      title:
                                                          'Please Select Employee');
                                                },
                                              );
                                            }
                                          }
                                        });
                                      },
                                      controller: taskController,
                                      placeholder: 'Task',
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all()),
                                    child: DropdownButton(
                                      borderRadius: BorderRadius.circular(20),
                                      focusColor: CupertinoColors.white,
                                      value: assignEmployee,
                                      hint: Text('Select Employee'),
                                      items: List.generate(
                                          HomePage.viewUserJson.user!.length,
                                          (index) {
                                        print(HomePage
                                            .viewUserJson.user![index].name);
                                        return DropdownMenuItem(
                                            value: HomePage
                                                .viewUserJson.user![index].name,
                                            child: Text(HomePage.viewUserJson
                                                .user![index].name!));
                                      }),
                                      onChanged: (value) {
                                        setState(() {
                                          assignEmployee = value!;
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                color: CupertinoColors.darkBackgroundGray,
                                child: Text('Add Task'),
                                onPressed: () {
                                  setState(() {
                                    if (assignEmployee != null &&
                                        taskController.text.isNotEmpty) {
                                      addTask(
                                          task: taskController.text,
                                          employee: assignEmployee!);
                                      isAddTask = false;
                                    } else {
                                      if (taskController.text.isEmpty) {
                                        showCupertinoDialog(
                                          context: context,
                                          builder: (context) {
                                            return dialog(
                                                title: 'Please Fill Task');
                                          },
                                        );
                                      } else {
                                        showCupertinoDialog(
                                          context: context,
                                          builder: (context) {
                                            return dialog(
                                                title:
                                                    'Please Select Employee');
                                          },
                                        );
                                      }
                                    }
                                  });
                                },
                              )
                            ],
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text('Add New Task',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Icon(CupertinoIcons.arrow_down),
                            )
                          ],
                        ),
                ),
              ),
            ),
            Flexible(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: isTaskLoad
                    ? ListView.builder(
                        shrinkWrap: isSeeMorePress,
                        itemCount:
                            isSeeMorePress ? taskResponse.length+1 : 6,
                        physics: isSeeMorePress
                            ? AlwaysScrollableScrollPhysics()
                            : NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {

                          print(
                              '++++++++++++ ${viewTaskJson.response![index].status}');
                          return CupertinoContextMenu(
                            actions: [
                              CupertinoContextMenuAction(
                                onPressed: () {
                                  removeTask(id: viewTaskJson.response![index].id!).then((value) => Navigator.pop(context));
                                },
                                child: Text(
                                  'Remove Task',
                                  style: TextStyle(
                                      color: CupertinoColors.systemRed,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailingIcon: CupertinoIcons.delete,
                                isDestructiveAction: true,
                              ),
                            ],
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 80,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 20),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: CupertinoColors.white,
                                                  width: 2))),
                                      child: index > 0
                                          ? Text(
                                              '$index.\t\t${taskResponse[index-1].task}')
                                          : Text('\t\t\tList of tasks',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                    )),
                                Expanded(
                                  child: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                color: CupertinoColors.white,
                                                width: 2),
                                            right: BorderSide(
                                                color: CupertinoColors.white,
                                                width: 2),
                                            bottom: BorderSide(
                                                color: CupertinoColors.white,
                                                width: 2))),
                                    child: index > 0
                                        ? CupertinoSwitch(
                                            value: assign[index-1],
                                            onChanged: (value) {
                                              setState(() {
                                                assign[index-1] = value;
                                                updateTaskStatus(id: taskResponse[index-1].id!, field: 'assign', update: '${assign[index-1]}');
                                              });
                                            },
                                          )
                                        : Center(
                                            child: Text(
                                              'Assigned',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: CupertinoColors.white,
                                              width: 2))),
                                  padding: EdgeInsets.only(left: 20),
                                  alignment: Alignment.centerLeft,
                                  child: index > 0
                                      ? Text(
                                          '${taskResponse[index-1].employee}')
                                      : Text('Employee Name',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                )),
                              ],
                            ),
                          );
                        },
                      )
                    : SizedBox(),
              ),
            ),
            !isSeeMorePress
                ? Padding(
                    padding: const EdgeInsets.all(30),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSeeMorePress = true;
                          });
                        },
                        child: Text('See more...')),
                  )
                : SizedBox()
          ],
        ));
  }

  late ViewTaskJson viewTaskJson;
  bool isTaskLoad = false;
  List <Task>taskResponse = [];
  Future<void> viewTask() async {
    var url =
        Uri.parse('https://himanshiflutter.000webhostapp.com/view_task.php');
    var response = await http.get(url);
    Map json = jsonDecode(response.body);
    viewTaskJson = ViewTaskJson(json: json);
    setState(() {
      assign.clear();
      taskResponse.clear();
      for (int i = 0; i < viewTaskJson.response!.length; i++) {
        print(viewTaskJson.response![i].task);
        if(viewTaskJson.response![i].status=="P"){
          taskResponse.add(viewTaskJson.response![i]);
        assign.add(viewTaskJson.response![i].assign == 'true');
      }
      }
      print(taskResponse.length);
      isTaskLoad = true;
    });
  }

  Widget dialog({required String title}) {
    return CupertinoAlertDialog(
      title: Text(title),
      actions: [
        CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Ok'))
      ],
    );
  }

  Future<void> addTask({
    required String task,
    required String employee,
  }) async {
    Map body = {
      'task': task,
      'employee': employee,
    };
    var url =
        Uri.parse('https://himanshiflutter.000webhostapp.com/add_task.php');
    var response = await http.post(url, body: body);
    Map json = jsonDecode(response.body);
    print(json);
    viewTask();
  }
  Future<void> removeTask({required id}) async {
    // https://himanshiflutter.000webhostapp.com/remove_task.php
    Map body = {
      'id': id,
    };
    var url =
    Uri.parse('https://himanshiflutter.000webhostapp.com/remove_task.php');
    var response = await http.post(url, body: body);
    Map json = jsonDecode(response.body);
    print(json);
    viewTask();
  }
  Future<void> updateTaskStatus(
      {required String id,
        required String field,
        required String update}) async {
    Map body = {
      'id': id,
      'field': field,
      'update': update,
    };
    print('***************${body}');
    var url =
    Uri.parse('https://himanshiflutter.000webhostapp.com/update_task.php');
    var response = await http.post(url, body: body);
    Map json = jsonDecode(response.body);
    print('+++++++++$json');
    viewTask();
  }
}
