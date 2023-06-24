class LoginJson {
  int? connection;
  int? result;
  List<User>? user;

  LoginJson({required Map json}) {
    List<User> temp = [];
    for (int i = 0; i < json['user'].length; i++) {
      User user = User(json: json['user'][i]);
      temp.add(user);
    }
    connection = json['connection'];
    result = json['result'];
    user = temp;
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? contact;
  String? salary;
  String? username;
  String? password;
  String? account_no;
  String? ifsc;
  String? role;
  String? post;

  User({required Map json}) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
    salary = json['salary'];
    username = json['username'];
    password = json['password'];
    account_no = json['account_no'];
    ifsc = json['ifsc'];
    role = json['role'];
    post = json['post'];
  }
}

class ViewUserJson {
  int? connection;
  int? result;
  List<User>? user;

  ViewUserJson({required Map json}) {
    List<User> temp = [];
    for (int i = 0; i < json['user'].length; i++) {
      User user = User(json: json['user'][i]);
      temp.add(user);
    }
    connection = json['connection'];
    result = json['result'];
    user = temp;
  }
}

class ViewChatJson {
  int? connection;
  int? result;
  List<Chat>? chat;

  ViewChatJson({required Map json}) {
    List<Chat> temp = [];

    for (int i = 0; i < json['chat'].length; i++) {
      Chat chat = Chat(json: json['chat'][i]);
      temp.add(chat);
    }
    chat = temp;
  }
}

class Chat {
  String? id;
  String? fromId;
  String? toId;
  String? massage;

  Chat({required Map json}) {
    id = json['id'];
    fromId = json['from_id'];
    toId = json['to_id'];
    massage = json['massage'];
  }
}

class DateJson {
  int? connection;
  int? result;
  List<Attendance>? attendance;

  DateJson({required Map json}) {
    List<Attendance> temp = [];
    for (int i = 0; i < json['response'].length; i++) {
      Attendance attendance = Attendance(json: json['response'][i]);
      temp.add(attendance);
    }
    attendance = temp;
  }
}

class Attendance {
  String? id;
  String? userid;
  String? date;
  String? attendance;

  Attendance({required Map json}) {
    id = json['id'];
    userid = json['userid'];
    date = json['date'];
    attendance = json['attendance'];
  }
}

class ViewTaskJson {
  int? connection;
  int? result;
  List<Task>? response;

  ViewTaskJson({required Map json}) {
    connection = json['connection'];
    result = json['result'];
    List<Task> temp = [];
    for (int i = 0; i < json['response'].length; i++) {
      Task task = Task(json: json['response'][i]);
      temp.add(task);
    }
    response = temp;
  }
}

class Task {
  String? id;
  String? task;
  String? employee;
  String? assign;
  String? status;

  Task({required Map json}) {
    id = json['id'];
    task = json['task'];
    employee = json['employee'];
    assign = json['assign'];
    status = json['status'];
  }
}
