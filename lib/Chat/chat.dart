import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:staff_management/Chat/chat_togather.dart';
import 'package:staff_management/Employee/employee.dart';
import 'package:staff_management/Login/login_page.dart';
import 'package:staff_management/json.dart';
import 'package:staff_management/main.dart';

class ChatPage extends StatefulWidget {
  static String toId='';
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<ChatPage> {
  late LoginJson loginJson;
  bool isChatOpen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewEmployee();
  }
bool   isDataLoad = false;
  Future<void> viewEmployee() async {
    var url = Uri.parse(
        'https://himanshiflutter.000webhostapp.com/view_employee.php');
    var response = await http.get(url);
    Map json = jsonDecode(response.body);
    loginJson = LoginJson(json: json);

    setState(() {
      isDataLoad = true;
    });
  }
  late String fromId;
  late String toId;
  @override
  Widget build(BuildContext context) {
    return isChatOpen?ChatTogether(fromId: fromId, toId: toId):CupertinoPageScaffold(
        backgroundColor: Colors.transparent,
        child: isDataLoad?ListView.builder(
          itemCount: HomePage.viewUserJson.user!.length,
          itemBuilder: (context, index) {
            return HomePage.viewUserJson.user![index].id!=LoginPage.currentUserid?Padding(
              padding: const EdgeInsets.all(10),
              child: CupertinoListTile(
                onTap: () {
                  setState(() {
                    isChatOpen = true;
                    ChatPage.toId = HomePage.viewUserJson.user![index].id!;
                    fromId = LoginPage.currentUserid;
                    toId = ChatPage.toId;
                  });
                  // HomePage.selectedDrawerIndex = 7;
                  // Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomePage(role: 'admin'),));
                },
                backgroundColor: CupertinoColors.white,
                title: Text(HomePage.viewUserJson.user![index].name!),
                leading: Container(
                  decoration: BoxDecoration(color: CupertinoColors.systemGrey,shape: BoxShape.circle),
                  child: Center(child: Text(HomePage.viewUserJson.user![index].name![0].toUpperCase())),
                ),
                subtitle: Text(HomePage.viewUserJson.user![index].contact!),
                trailing: Text(HomePage.viewUserJson.user![index].post!),
              ),
            ):SizedBox(height: 0);
          },
        ):Center(child: CupertinoActivityIndicator()));
  }
}
