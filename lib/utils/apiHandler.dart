import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final String firstName;
  final String lastName;
  final String gender;
  final String image;

  User({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
  });
}

class ApiHandler {
  static Future<List<User>> fetchRandomUsers(int numberOfUsers) async {
    var response = await http
        .get(Uri.parse('https://randomuser.me/api/?results=$numberOfUsers'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var results = data['results'];

      List<User> users = results.map<User>((user) {
        return User(
          firstName: user['name']['first'],
          lastName: user['name']['last'],
          gender: user['gender'],
          image: user['picture']['large'],
        );
      }).toList();

      return users;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
