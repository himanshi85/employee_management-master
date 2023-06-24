import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staff_management/Login/login_page.dart';

class ViewDetailPage extends StatefulWidget {
  const ViewDetailPage({Key? key}) : super(key: key);

  @override
  State<ViewDetailPage> createState() => _ViewDetailPageState();
}

class _ViewDetailPageState extends State<ViewDetailPage> {
  TextStyle h1 = TextStyle(
      fontSize: 20, fontWeight: FontWeight.w500, color: CupertinoColors.white);
  TextStyle h2 = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, color: CupertinoColors.white);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Color(0x00000000),
        child: Column(
          children: [
            Text(
              'Your Details',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            Wrap(
              children: [
                Card(
                  elevation: 4,
                  color: CupertinoColors.secondaryLabel,
                  margin: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 120,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Your Name',
                              style: h2,
                            ),
                          ),
                          Card(
                            elevation: 6,
                            color: CupertinoColors.systemGrey,
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: Center(
                                child: Text(
                                  LoginPage.loginJson.user![0].name!,
                                  style: h1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  color: CupertinoColors.secondaryLabel,
                  margin: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 120,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Your Email',
                              style: h2,
                            ),
                          ),
                          Card(
                            elevation: 6,
                            color: CupertinoColors.systemGrey,
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: Center(
                                child: Text(
                                  LoginPage.loginJson.user![0].email!,
                                  style: h1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  color: CupertinoColors.secondaryLabel,
                  margin: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 120,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Your Contact',
                              style: h2,
                            ),
                          ),
                          Card(
                            elevation: 6,
                            color: CupertinoColors.systemGrey,
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: Center(
                                child: Text(
                                  LoginPage.loginJson.user![0].contact!,
                                  style: h1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  color: CupertinoColors.secondaryLabel,
                  margin: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 120,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Your username',
                              style: h2,
                            ),
                          ),
                          Card(
                            elevation: 6,
                            color: CupertinoColors.systemGrey,
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: Center(
                                child: Text(
                                  LoginPage.loginJson.user![0].username!,
                                  style: h1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  color: CupertinoColors.secondaryLabel,
                  margin: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 120,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Your Bank Account No',
                              style: h2,
                            ),
                          ),
                          Card(
                            elevation: 6,
                            color: CupertinoColors.systemGrey,
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: Center(
                                child: Text(
                                  LoginPage.loginJson.user![0].account_no!,
                                  style: h1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  color: CupertinoColors.secondaryLabel,
                  margin: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 120,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Your IFSC code',
                              style: h2,
                            ),
                          ),
                          Card(
                            elevation: 6,
                            color: CupertinoColors.systemGrey,
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: Center(
                                child: Text(
                                  LoginPage.loginJson.user![0].ifsc!,
                                  style: h1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  color: CupertinoColors.secondaryLabel,
                  margin: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 120,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Your Salary',
                              style: h2,
                            ),
                          ),
                          Card(
                            elevation: 6,
                            color: CupertinoColors.systemGrey,
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: Center(
                                child: Text(
                                  LoginPage.loginJson.user![0].salary!,
                                  style: h1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
