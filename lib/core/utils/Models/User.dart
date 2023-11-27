// ignore_for_file: non_constant_identifier_names, file_names

class User {
  String email, password, name, mobile;
  int user_type;
  User({
    required this.email,
    required this.password,
    required this.name,
    required this.user_type,
    required this.mobile,
  });
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'user_type': 1,
      'mobile': mobile,
    };
  }
}
