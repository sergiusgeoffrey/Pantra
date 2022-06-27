import 'package:http/http.dart' as http;

class LoginService {
  Future<bool> login({
    String nrp = "",
    String password = "",
  }) async {
    if (nrp == "" || password == "") return false;

    final response = await http.post(
      Uri.parse("https://bem-internal.petra.ac.id/reach/api/login/index.php"),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'nrp': nrp,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      return false;
    } else {
      throw Exception('Login failed');
    }
  }
}
