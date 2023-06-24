import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:staff_management/Chat/chat.dart';
import 'package:staff_management/Login/login_page.dart';
import 'package:staff_management/json.dart';
import 'package:staff_management/main.dart';

class ChatTogether extends StatefulWidget {
  const ChatTogether({Key? key, required String fromId, required String toId})
      : super(key: key);

  @override
  State<ChatTogether> createState() => _ChatTogetherState();
}

class _ChatTogetherState extends State<ChatTogether> {
  TextEditingController chatController = TextEditingController();
  late ViewChatJson viewChatJson;
  bool isChatLoad = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewMassage(fromId: LoginPage.currentUserid, toId: ChatPage.toId);
  }

  late LoginJson loginJson;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ScrollConfiguration(
              behavior: ScrollConfiguration.of(context)
                  .copyWith(scrollbars: false),
              child: Flexible(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: isChatLoad ?  viewChatJson.chat!.length : 0,
                  itemBuilder: (context, index) {
                    bool b =
                        ChatPage.toId == viewChatJson.chat![index].toId;
                    return Align(
                      alignment: b
                          ? FractionalOffset.centerRight
                          : FractionalOffset.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: EdgeInsets.fromLTRB(
                            b ? 200 : 5, 5, b ? 5 : 200, 5),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          viewChatJson.chat![index].massage!,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: CupertinoTextField(
                autofocus: true,
                placeholder: 'Type your Massage',
                onChanged: (value) {
                  if (value.length == 1) {
                    setState(() {});
                  } else {
                    setState(() {});
                  }
                },
                onSubmitted: (value) {
                  addChat(
                      fromId: LoginPage.currentUserid,
                      toId: ChatPage.toId,
                      massage: chatController.text);
                  chatController.text = '';
                },
                controller: chatController,
                suffix: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(CupertinoIcons.share_solid),
                ),
                suffixMode: chatController.text.isEmpty
                    ? OverlayVisibilityMode.never
                    : OverlayVisibilityMode.always,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> viewMassage(
      {required String fromId, required String toId}) async {
    Map body = {
      'from_id': fromId,
      'to_id': fromId,
    };
    var url =
        Uri.parse('https://himanshiflutter.000webhostapp.com/view_chat.php');
    var response = await http.post(url, body: body);
    Map json = jsonDecode(response.body);
    viewChatJson = ViewChatJson(json: json);
    setState(() {
      isChatLoad = true;
      scrollToBottom();
    });

  }

  void scrollToBottom() {
    if(scrollController.hasClients) {
      final bottomOffset = scrollController.position.maxScrollExtent;
      scrollController.animateTo(
        bottomOffset + 60,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> addChat(
      {required String fromId,
      required String toId,
      required String massage}) async {
    Map body = {
      'from_id': fromId,
      'to_id': toId,
      'massage': massage,
    };
    var url =
        Uri.parse('https://himanshiflutter.000webhostapp.com/add_chat.php');
    var response = await http.post(url, body: body);
    Map json = jsonDecode(response.body);

    viewMassage(fromId: fromId, toId: toId);
  }
}
