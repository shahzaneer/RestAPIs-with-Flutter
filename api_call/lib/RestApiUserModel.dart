import 'dart:convert';

import 'package:api_call/Models/post_model/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserApp extends StatefulWidget {
  const UserApp({super.key});

  @override
  State<UserApp> createState() => _UserAppState();
}

class _UserAppState extends State<UserApp> {
  List<UserModel> users = [];

  Future<List<UserModel>> getUsers() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    // Postman se dekh kr maaloon hua hai k yeh aik List hogi jo data main ayegi type Json Object hogi!
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        users.add(UserModel.fromJson(i));
        print(users);
      }

      return users;
    } else {
      return users;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Users"),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getUsers(),
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ReusableRow(
                                  title: "Name",
                                  desc: snapshot.data![index].name.toString()),
                              ReusableRow(
                                  title: "Email",
                                  desc: snapshot.data![index].email.toString()),
                              ReusableRow(
                                  title: "Phone No",
                                  desc: snapshot.data![index].phone.toString()),
                              ReusableRow(
                                  title: "Company",
                                  desc: snapshot.data![index].company!.name
                                      .toString())
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//! Components Building
// * Professional Practice++;

class ReusableRow extends StatelessWidget {
  final String title, desc;
  const ReusableRow({super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(desc)],
      ),
    );
  }
}







//! Still the building of Complex Json Structured Model into Dart with the help of Plugin is ambiguous