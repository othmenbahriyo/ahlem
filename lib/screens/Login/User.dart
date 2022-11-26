import 'package:http/http.dart' as http;

class UserService {
  @override

  Future save({required String email, required String password}) async {
    await http.post(
        Uri.parse(
          "http://192.168.100.3:1337/api/auth/local",
        ),
        headers: <String, String>{
         'Context-Type': 'application/json; charset=UTF-8',
        },
        body: <String, String>{
          'email': email,
          'password': password,
        });

  }
}
