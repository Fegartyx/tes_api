import '../model/user_model.dart';
import '../service/api_instance.dart';

ApiInstance apiInstance = ApiInstance();
UserModel userModel = UserModel();
List<UserModel> users = [];

Future getUser() async {
  await apiInstance.getUser('2').then((value) => userModel = value);
}

Future getAllUser() async {
  await apiInstance.getAllUser().then((value) {
    print(value);
    for (var item in value) {
      users.add(item);
      print(item);
    }
  });
}
