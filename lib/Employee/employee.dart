import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:staff_management/json.dart';
import 'package:staff_management/main.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}


class _EmployeePageState extends State<EmployeePage> {
  bool isDataLoad = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController accNoController = TextEditingController();
  TextEditingController ifscController = TextEditingController();





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewEmployee();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Color(0x000000),
        child: Stack(
          children: [
            isDataLoad
                ? GridView.builder(
                    itemCount: HomePage.viewUserJson.user!.length - 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 6),
                    itemBuilder: (context, index) {
                      return CupertinoContextMenu(
                          actions: [
                            CupertinoContextMenuAction(
                              onPressed: () {
                                post = HomePage
                                    .viewUserJson.user![index + 1].post!;
                                nameController.text = HomePage
                                    .viewUserJson.user![index + 1].name!;
                                salaryController.text = HomePage
                                    .viewUserJson.user![index + 1].salary!;
                                emailController.text = HomePage
                                    .viewUserJson.user![index + 1].email!;
                                contactController.text = HomePage
                                    .viewUserJson.user![index + 1].contact!;
                                usernameController.text = HomePage
                                    .viewUserJson.user![index + 1].username!;
                                passwordController.text = HomePage
                                    .viewUserJson.user![index + 1].password!;
                                accNoController.text = HomePage
                                    .viewUserJson.user![index + 1].account_no!;
                                ifscController.text = HomePage
                                    .viewUserJson.user![index + 1].ifsc!;
                                Navigator.pop(context);
                                showModalBottomSheet(
                                  // isDismissible: false,
                                  backgroundColor: CupertinoColors.inactiveGray,
                                  context: context,
                                  builder: (context) {
                                    updateIndex = index;
                                    return getBottomSheet(isForUpdate: true);
                                  },
                                );
                              },
                              child: Text(
                                'Edit',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              trailingIcon:
                                  CupertinoIcons.pencil_ellipsis_rectangle,
                            ),
                            CupertinoContextMenuAction(
                              onPressed: () {
                                removeEmployee(
                                        id: HomePage
                                            .viewUserJson.user![index + 1].id!)
                                    .then((value) {
                                  viewEmployee()
                                      .then((value) => Navigator.pop(context));
                                });
                              },
                              child: Text(
                                'Remove',
                                style: TextStyle(
                                    color: CupertinoColors.systemRed,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailingIcon: CupertinoIcons.delete,
                              isDestructiveAction: true,
                            ),
                          ],
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(border: Border.all()),
                            child: Center(
                                child: Text(HomePage
                                    .viewUserJson.user![index + 1].name!)),
                          ));
                    },
                  )
                : Center(child: CupertinoActivityIndicator()),
            Positioned(
              right: 10,
              bottom: 10,
              child: GestureDetector(
                onTap: () {

                  post = null;
                  nameController.text = '';
                  salaryController.text = '';
                  emailController.text = '';
                  contactController.text = '';
                  usernameController.text = '';
                  passwordController.text = '';
                  accNoController.text = '';
                  ifscController.text = '';
                  showModalBottomSheet(
                    backgroundColor: CupertinoColors.inactiveGray,
                    context: context,
                    builder: (context) {
                      return getBottomSheet();
                    },
                  );
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: CupertinoColors.inactiveGray, blurRadius: 5)
                  ], color: CupertinoColors.white, shape: BoxShape.circle),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.add,
                      size: 30,
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Future<void> viewEmployee() async {
    var url = Uri.parse(
        'https://himanshiflutter.000webhostapp.com/view_employee.php');
    var response = await http.get(url);
    Map json = jsonDecode(response.body);
    HomePage.viewUserJson = ViewUserJson(json: json);

    setState(() {
      isDataLoad = true;
    });
  }

  Future<void> addEmployee({
    String name = '',
    String salary = '',
    String email = '',
    String contact = '',
    String username = '',
    String password = '',
    String acc_no = '',
    String ifsc = '',
  }) async {
    Map body = {
      'name': name,
      'salary': salary,
      'email': email,
      'contact': contact,
      'username': username,
      'password': password,
      'acc_no': acc_no,
      'ifsc': ifsc,
      'post': post
    };
    print(body);
    var url =
        Uri.parse('https://himanshiflutter.000webhostapp.com/add_employee.php');
    var response = await http.post(url, body: body);
    Map json = jsonDecode(response.body);
    print(json);
  }
  RegExp email =RegExp( r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp name =RegExp( r'^[a-zA-Z]([._-]?[a-zA-Z0-9]+)*$');
  RegExp password =RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');


  bool emsa=false;
  bool nasa=false;
  bool pasa=false;

  String emaill="";
  String namee="";
  String passwordd="";


  int updateIndex= -1;
  String? post;
  List<String> posts = ['HR', 'Manager', 'Employee'];

  Widget getBottomSheet({bool isForUpdate = false}) {
    return Container(
      padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Personal Details',
                  style: TextStyle(fontSize: 22),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  child: StatefulBuilder(
                    builder: (context, setState1) => DropdownButton(
                      value: post,
                      hint: Text('Select Post'),
                      items: List.generate(
                          posts.length,
                          (index) => DropdownMenuItem(
                                child: Text(posts[index]),
                                value: posts[index],
                              )),
                      onChanged: (value) {
                        setState1(() {
                          post = value;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoTextField(
                          controller: nameController, placeholder: 'Name',


                      ),
                    ),

                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: CupertinoTextField(
                           keyboardType: TextInputType.number,
                          controller: salaryController, placeholder: 'Salary'),
                    ),
                  ],
                )),
            Text(
              'Contact Details',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoTextField(
                          controller: emailController, placeholder: 'Email',

                      //
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //                   border: true
                      //                       ? Border.all(color: Colors.red)
                      //                            : Border.all(color: Colors.white),
                      //
                      //
                      //
                      // )
                    ),
                    ),
                    // if(emsa) Text("enter a valid email"),
                    SizedBox(
                      width: 50,
                    ),
                    
                    Expanded(
                      child: CupertinoTextField(
                          maxLength: 10,

                          keyboardType: TextInputType.number,
                          controller: contactController,
                          placeholder: 'Contact'),
                    ),
                  ],
                )),
            Text(
              'Login Details',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoTextField(
                          controller: usernameController,
                          placeholder: 'username'),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: CupertinoTextField(
                          controller: passwordController,
                          obscureText: true,
                          placeholder: 'Password'),
                    ),
                  ],
                )),
            Text(
              'Bank Details',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoTextField(
                          maxLength: 12,

                          controller: accNoController,
                          placeholder: 'Account no.'),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: CupertinoTextField(
                          controller: ifscController, placeholder: 'IFSC Code'),
                    ),
                  ],
                )),
            Center(
              child: CupertinoButton(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: CupertinoColors.white,
                child: Text(
                  isForUpdate ? 'Update' : 'Add Employee',
                  style: TextStyle(color: CupertinoColors.black),
                ),
                onPressed: () {
                  setState(() {
                    nasa=false;
                    emsa=false;
                    pasa=false;
                    if (isForUpdate) {
                      updateEmployee(id: HomePage
                          .viewUserJson.user![updateIndex + 1].id!).then((value) {
                        viewEmployee()
                            .then((value) => Navigator.pop(context));
                      });
                    } else {
                      if (nameController.text.isEmpty) {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) => dialog(title: 'Please Fill Name'),
                        );
                      } else if (salaryController.text.isEmpty) {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) =>
                              dialog(title: 'Please Fill Salary'),
                        );
                      } else if (emailController.text.isEmpty) {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) =>
                              dialog(title: 'Please Fill Email'),
                        );
                      } else if (contactController.text.isEmpty) {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) =>
                              dialog(title: 'Please Fill Contact'),
                        );
                      } else if (usernameController.text.isEmpty) {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) =>
                              dialog(title: 'Please Fill Username'),
                        );
                      } else if (passwordController.text.isEmpty) {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) =>
                              dialog(title: 'Please Fill Password'),
                        );
                      } else if (accNoController.text.isEmpty) {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) =>
                              dialog(title: 'Please Fill A/c No'),
                        );
                      } else if (ifscController.text.isEmpty) {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) => dialog(title: 'Please Fill IFSC'),
                        );
                      } else if (post == null) {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) =>
                              dialog(title: 'Please Select Post'),
                        );
                      } else {

                         if(!name.hasMatch(usernameController.text)){
                          nasa=true;
                          namee="Please enter a valid username";

                        }
                        else if(!email.hasMatch(emailController.text)){
                          emsa=true;
                          emaill="Please enter a valid email";

                        }
                        else if(!password.hasMatch(passwordController.text)){
                          pasa=true;
                          passwordd="Please enter a valid password";

                        }
                        addEmployee(
                          name: nameController.text,
                          salary: salaryController.text,
                          email: emailController.text,
                          contact: contactController.text,
                          username: usernameController.text,
                          password: passwordController.text,
                          acc_no: accNoController.text,
                          ifsc: ifscController.text,
                        ).then((value) {
                          Navigator.pop(context);
                          viewEmployee();
                        });
                      }
                    }
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  CupertinoAlertDialog dialog({required String title}) {
    return CupertinoAlertDialog(
      title: Text(title),
      actions: [
        CupertinoDialogAction(
          child: Text('Ok'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
//https://himanshiflutter.000webhostapp.com/update_employee.php
  Future<void> updateEmployee({required String id}) async {
    Map body = {
      'id': id,
      'name' : nameController.text,
      'email' : emailController.text,
      'contact' : contactController.text,
      'salary' : salaryController.text,
      'username' : usernameController.text,
      'password' : passwordController.text,
      'account_no' : accNoController.text,
      'ifsc' : ifscController.text,
      'post' : post,
    };
    var url = Uri.parse(
        'https://himanshiflutter.000webhostapp.com/update_employee.php');
    var response = await http.post(url, body: body);
    Map json = jsonDecode(response.body);
    print(json);
  }

  Future<void> removeEmployee({required String id}) async {
    Map body = {
      'id': id,
    };
    var url = Uri.parse(
        'https://himanshiflutter.000webhostapp.com/delete_employee.php');
    var response = await http.post(url, body: body);
    Map json = jsonDecode(response.body);
  }
}
