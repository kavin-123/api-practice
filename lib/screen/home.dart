import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];
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
              final name = user['name']['first'];
              final email = user['email'];
              final image = user['picture']['thumbnail'];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(image),
                ),
                title: Text(name.toString()),
                subtitle: Text(email),
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

    setState(() {
      users = json['results'];
    });

    print(
      'Fetched user complete',
    );
  }
}
