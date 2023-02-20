import 'package:flutter/material.dart';
import 'package:random_user_api_calls/Model/User_Info.dart';
import 'package:random_user_api_calls/Service/user_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ramdom user'),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            final user = users[index];
            final name = user.name;
            final email = user.email;
            return ListTile(
              title: Text(name.first),
              subtitle: Text(email),
              
            );
          }),
      
    );
  }

  Future <void> fetchUsers() async {
    final response = await UserApi.fetchUsers();
    setState(() {
      users = response;
    });
  }
}
