import 'dart:convert';

import 'package:api/model/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 224, 253, 255),
            centerTitle: true,
            title: const Text('Rest API')),
        backgroundColor: Color.fromARGB(255, 252, 252, 252),
        body: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              // final email = user.email;
              // final color = user.gender == 'male'
              //   ? Colors.redAccent
              //   : Color.fromARGB(255, 214, 172, 19);

              return ListTile(
                title: Text(user.name.title),
                subtitle: Text(user.phone),
                //tileColor: color,
              );
            }),
        floatingActionButton: FloatingActionButton(onPressed: fetchUsers));
  }

  void fetchUsers() async {
    print('FetchedUser');
    const url = 'https://randomuser.me/api/?results=500';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final transformed = results.map((e) {
      final name = Username(
          title: e['name']['title'],
          last: e['name']['last'],
          first: e['name']['first']);
      return User(
          phone: e['phone'],
          cell: e['cell'],
          nat: e['nat'],
          gender: e['gender'],
          email: e['email'],
          name: name);
    }).toList();

    setState(() {
      users = transformed;
    });

    print(
      'Fetched user complete',
    );
  }
}
