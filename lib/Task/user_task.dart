import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:staff_management/Login/login_page.dart';
import 'package:staff_management/Task/admin_task.dart';
import 'package:staff_management/json.dart';

class UserTaskPage extends StatefulWidget {
  const UserTaskPage({Key? key}) : super(key: key);

  @override
  State<UserTaskPage> createState() => _UserTaskPageState();
}

class _UserTaskPageState extends State<UserTaskPage> {
  bool isSeeMorePress = false;
  int editEmployeeIndex = -1;
  List<String> tasks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewTask();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.transparent,
        child: tasks.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: isSeeMorePress,
                      itemCount: tasks.length > 6
                          ? isSeeMorePress
                              ? tasks.length + 1
                              : 6
                          : tasks.length + 1,
                      physics: isSeeMorePress
                          ? AlwaysScrollableScrollPhysics()
                          : NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                            height: 80,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: CupertinoColors.white,
                                        width: 2))),
                            child: CupertinoListTile(
                              title: Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: index > 0
                                    ? Text(
                                        maxLines: 2,
                                        '$index.\t\t${tasks[index - 1]}',
                                      )
                                    : Text('\t\t\tYour Task',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                              ),
                              trailing: index > 0
                                  ? CupertinoButton(
                                      color: CupertinoColors.systemGreen,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: const Text('Mark as Completed'),
                                      onPressed: () {
                                        updateTaskStatus(
                                            id: yourTask[index - 1].id!,
                                            field: 'status',
                                            update: 'C');
                                      },
                                    )
                                  : null,
                            ));
                      },
                    ),
                  ),
                  tasks.length > 6 && !isSeeMorePress
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
              )
            : Center(child: Text('No Task found')));
  }

  bool isTaskLoad = true;
  late ViewTaskJson viewTaskJson;
  List<Task> yourTask = [];

  Future<void> viewTask() async {
    var url =
        Uri.parse('https://himanshiflutter.000webhostapp.com/view_task.php');
    var response = await http.get(url);
    Map json = jsonDecode(response.body);
    viewTaskJson = ViewTaskJson(json: json);
    setState(() {
      tasks.clear();
      yourTask.clear();
      for (int i = 0; i < viewTaskJson.response!.length; i++) {
        if (viewTaskJson.response![i].employee ==
                LoginPage.loginJson.user![0].name &&
            viewTaskJson.response![i].status == 'P') {
          tasks.add(viewTaskJson.response![i].task!);
          yourTask.add(viewTaskJson.response![i]);
        }
      }
      debugPrint("log : tasks ---> $tasks");
      isTaskLoad = true;
    });
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
    print(body);
    var url =
        Uri.parse('https://himanshiflutter.000webhostapp.com/update_task.php');
    var response = await http.post(url, body: body);
    Map json = jsonDecode(response.body);
    print(json);
    viewTask();
  }
}
