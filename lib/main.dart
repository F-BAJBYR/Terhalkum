import 'dart:io'; // مكتبة لتهيئة HttpOverrides
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:terhalkum/Controller/user_dashboard.dart';
import 'package:terhalkum/managment/customer_support_managment.dart';
import 'package:terhalkum/managment/dashboard_screen.dart';
import 'package:terhalkum/managment/entities_establishments_managment.dart';
import 'package:terhalkum/managment/offers_discounts_managment.dart';
import 'package:terhalkum/managment/reservations_managment_screen.dart';
import 'package:terhalkum/managment/trip_management_screen.dart';
import 'package:terhalkum/Authentication/signup.dart'; // Replace with the correct main import
import 'package:terhalkum/Authentication/login.dart'; // Replace with the correct main import
import 'package:terhalkum/pages/TrhAlkM-1.dart';
import 'dart:convert';

import 'package:terhalkum/views/homeView.dart';

// إضافة HttpOverrides لتجاوز مشاكل SSL
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  // تعيين HttpOverrides لتجاوز مشاكل SSL
  HttpOverrides.global = MyHttpOverrides();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MySQL App',
      home: const LoginPage(), // صفحة تسجيل الدخول
      routes: <String, WidgetBuilder>{
        "/login": (context) => const LoginPage(),
        "/signup": (context) => const RegisterPage(),
        "/user_dashboard": (context) => const TrhAlkM1(),
        "/user_management_screen": (context) => const UserManagementScreen(title: 'إدارة المستخدمين'),
        "/trip_management_screen": (context) => const TripManagementScreen(title: 'إدارة الرحلات'),
        "/dashboard_screen": (context) => const DashboardScreen(title: 'لوحة القيادة'),
        "/customer_support_managment": (context) => const CustomerSupportManagementScreen(title: 'دعم العملاء'),
        "/entities_establishments_managment": (context) => const EntitiesEstablishmentsManagementScreen(title: 'إدارة الجهات والمنشآت'),
        "/offers_discounts_managment": (context) => const OffersDiscountsManagementScreen(title: 'إدارة الخصومات والعروض'),
        "/reservations_managment_screen": (context) => const ReservationsManagementScreen(title: 'إدارة الحجوزات'),
        "/homeView": (context) => const HomeView(),
      },
    );
  }
}

// صفحة تسجيل الدخول
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/user_dashboard');
          },
          child: const Text('Login and Navigate to Dashboard'),
        ),
      ),
    );
  }
}

// إدارة المستخدمين
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
    users = fetchUsers(); // استدعاء المستخدمين من قاعدة البيانات
  }

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('http://localhost/api/get_users.php')); // الاتصال بواجهة API

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<User>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading users'));
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
    );
  }
}

// نموذج بيانات المستخدم
class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

// بطاقة المستخدم في واجهة المستخدمين
class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(user.name),
        subtitle: Text(user.email),
      ),
    );
  }
}

// شاشة رئيسية كمثال
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tourism App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/user_management_screen');
              },
              child: const Text('إدارة المستخدمين'),
            ),
          ],
        ),
      ),
    );
  }
}
