class RegisterModel {
  bool? status;
  String? message;
  RegisterInfo? data;

  RegisterModel.FormJason(Map<String, dynamic> jason) {
    status = jason['status'];
    message = jason['message'];
    data = jason['status'] ? RegisterInfo.FormJason(jason['data']) : null;
  }
}

class RegisterInfo {
  String? UserName;

  RegisterInfo.FormJason(Map<String, dynamic> jason) {
    UserName = jason['name'];
  }
}
