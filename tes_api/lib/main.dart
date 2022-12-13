import 'package:flutter/material.dart';
import 'package:tes_api/model/create_user.dart';
import 'package:tes_api/model/user_model.dart';
import 'package:tes_api/service/api_instance.dart';
import 'package:tes_api/widget/shimmer_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyWidget());
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  CreateUser createUser = CreateUser();
  ApiInstance apiInstance = ApiInstance();
  UserModel userModel = UserModel();
  List<UserModel> users = [];

  Future getUser() async {
    await apiInstance.getUser('2').then((value) => userModel = value);
    setState(() {});
  }

  Future getAllUser() async {
    await apiInstance.getAllUser().then((value) {
      print(value);
      for (var item in value) {
        users.add(item);
        print(item);
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future openDialog() => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text('User Created'),
              content: Text(
                  "id: ${createUser.id}, name: ${createUser.name}, job: ${createUser.job} "),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ],
            ));

    Widget buildShimmer() {
      return const ListTile(
        title: ShimmerWidget.rectangular(height: 16, width: 8),
        subtitle: ShimmerWidget.rectangular(height: 14),
        leading: ShimmerWidget.rectangular(height: 64, width: 64),
      );
    }

    Widget showAllUsers(String page) {
      return FutureBuilder<List<UserModel>>(
          future: apiInstance.getAllUser(page: page),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return buildShimmer();
                  });
            } else if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Text('No User Data');
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(
                          snapshot.data![index].avatar!,
                          width: 64,
                          fit: BoxFit.cover,
                        ),
                        title: Text(snapshot.data![index].name!),
                        subtitle: Text(snapshot.data![index].email!),
                      );
                    });
              }
            } else {
              print(snapshot.error);
              return const Text('No User Data');
            }
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reqres.in'),
      ),
      body: showAllUsers('2'),
      // TODO: Register
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          apiInstance.registerUser('Badung', 'Freelancer').then((value) {
            createUser = value;
          });
          openDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
