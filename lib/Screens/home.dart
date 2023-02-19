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
        title: const Text('Ramdom user'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context,index) {
          final user = users[index];
          final email = user['email'];
          final name = user['name']['last'];
          final imgUrl = user['picture']['thumbnail'];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(imgUrl)),
            title: Text(name),
            subtitle: Text(email),
          );
      } ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        child: const Icon(Icons.add),
      ),
    );
  }
  
  void fetchUsers() async {
    print("FetchUsers started");
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    print('Fetch users completed');
  }
}
