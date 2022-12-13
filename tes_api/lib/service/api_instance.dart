import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tes_api/model/create_user.dart';

import '../model/user_model.dart';

class ApiInstance {
  String apiUrl = "https://reqres.in/api";
  Future<CreateUser> registerUser(String name, String job) async {
    String regApi = '$apiUrl/users';
    var apiResult =
        await http.post(Uri.parse(regApi), body: {'name': name, 'job': job});
    var jsonObj = json.decode(apiResult.body);
    print(jsonObj);
    return CreateUser.fromJson(jsonObj);
  }

  Future<UserModel> getUser(String id) async {
    String getApi = '$apiUrl/users/$id';
    var apiResult = await http.get(Uri.parse(getApi));
    var jsonObj = json.decode(apiResult.body)['data'];
    print(jsonObj);
    return UserModel.fromJson(jsonObj);
  }

  Future<List<UserModel>> getAllUser({String? page = '1'}) async {
    String getApi = '$apiUrl/users?page=$page';
    var apiResult = await http.get(Uri.parse(getApi));
    var jsonObj = json.decode(apiResult.body)['data'];
    print(jsonObj);
    List<UserModel> listUser = [];
    for (var value in jsonObj) {
      listUser.add(UserModel.fromJson(value));
    }
    return listUser;
  }
}
