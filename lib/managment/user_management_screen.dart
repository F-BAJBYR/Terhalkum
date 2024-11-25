import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const UserManagementScreen(title: 'إدارة المستخدمين'),
      theme: ThemeData(fontFamily: 'Arial'), // لضمان دعم اللغة العربية.
    );
  }
}

class UserManagementScreen extends StatefulWidget {
  final String title;

  const UserManagementScreen({super.key, required this.title});

  @override
  UserManagementScreenState createState() => UserManagementScreenState();
}

class UserManagementScreenState extends State<UserManagementScreen> {
  late Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    users = fetchUsers();
  }

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://127.0.0.1/api/users.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('فشل في تحميل المستخدمين');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 85, 28, 135),
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBox(),
            const SizedBox(height: 20.0),
            Expanded(
              child: FutureBuilder<List<User>>(
                future: users,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading data'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No users found'));
                  }

                  var userList = snapshot.data!;
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return UserCard(user: userList[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, color: Colors.grey),
            label: '',
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 85, 28, 135),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 10.0),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'البحث عن المستخدم',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String role;

  User({required this.id, required this.name, required this.email, required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user_id'].toString(),
      name: json['user_name'],
      email: json['user_email'],
      role: json['user_role'],
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(user.id, style: const TextStyle(color: Colors.black)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: const TextStyle(color: Colors.black)),
                Text(user.email, style: const TextStyle(color: Colors.grey)),
                Text('Role: ${user.role}', style: const TextStyle(color: Colors.blue)),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    // فتح شاشة تعديل المستخدم
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // حذف المستخدم
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
