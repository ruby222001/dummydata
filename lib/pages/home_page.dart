import 'dart:convert';

import 'package:api/model/list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<Users> users = [];

//get users
  Future getUsers() async {
    var response = await http.get(Uri.parse('https://dummyjson.com/users'));
    var jsonData = jsonDecode(response.body);
    for (var eachUser in jsonData['users']) {
      final user = Users(
        id: eachUser['id'],
        firstName: eachUser['firstName'],
        lastName: eachUser['lastName'],
        image: eachUser['image'],
      );
      users.add(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    getUsers();
    return Scaffold(
backgroundColor: Color.fromARGB(255, 149, 90, 189),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 152, 60, 232),
          centerTitle: true,
         title:const  Text('API',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
        body: FutureBuilder(
            future: getUsers(),
            builder: (context, snapshot) {
              //is it done reloading

              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: users.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            title: Text(users[index].firstName),
                            subtitle: Text(users[index].lastName),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(users[index].image),
                            ),
                          ),
                        ));
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
