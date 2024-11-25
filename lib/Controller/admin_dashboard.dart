import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:terhalkum/main.dart';
import 'package:terhalkum/managment/customer_support_managment.dart';
import 'package:terhalkum/managment/entities_establishments_managment.dart';
import 'package:terhalkum/managment/offers_discounts_managment.dart';
import 'package:terhalkum/managment/reservations_managment_screen.dart';
import 'package:terhalkum/managment/trip_management_screen.dart';

void main() {
  runApp(const AdminPanelApp());
}

class AdminPanelApp extends StatelessWidget {
  const AdminPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'لوحة تحكم ترحالكم',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // خلفية ناعمة رمادية
      ),
      home: const AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  Future<Map<String, dynamic>> fetchStatistics() async {
    final response = await http.get(Uri.parse('https://127.0.0.1/api/get_stats.php'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load statistics');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة القيادة'),
      ),
      drawer: const AdminSideMenu(), // إضافة القائمة الجانبية هنا
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchStatistics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var stats = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 1.1,
                children: <Widget>[
                  AdminCard(title: 'المستخدمين', value: stats['users'].toString()),
                  AdminCard(title: 'الرحلات', value: stats['trips'].toString()),
                  AdminCard(title: 'الحجوزات', value: stats['bookings'].toString()),
                  AdminCard(title: 'ربح', value: '${stats['profit']} ريال'),
                ],
              ),
            );
          } else {
            return const Center(child: Text('لا توجد بيانات متاحة'));
          }
        },
      ),
    );
  }
}

class AdminCard extends StatelessWidget {
  final String title;
  final String value;

  const AdminCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8, // إضافة الظل
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // زوايا دائرية
      ),
      color: Colors.white, // لون البطاقة أبيض
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87, // لون النص الرمادي الغامق
                fontWeight: FontWeight.w600, // زيادة سماكة العنوان
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              value,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF523A95), // اللون البنفسجي الداكن للأرقام
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class AdminSideMenu extends StatelessWidget {
  const AdminSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 82, 58, 149),
            ),
            child: Text(
              'قائمة الإدارة',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text('لوحة القيادة'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdminDashboard()),
              );
            },
          ),
          ListTile(
            title: const Text('إدارة المستخدمين'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserManagementScreen(title: 'إدارة المستخدمين')),
              );
            },
          ),
          ListTile(
            title: const Text('إدارة الرحلات'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TripManagementScreen(title: 'إدارة الرحلات')),
              );
            },
          ),
          ListTile(
            title: const Text('إدارة الحجوزات'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ReservationsManagementScreen(title: 'إدارة الحجوزات')),
              );
            },
          ),
          ListTile(
            title: const Text('إدارة الجهات والمنشئات'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EntitiesEstablishmentsManagementScreen(
                      title: 'إدارة الجهات والمنشئات',
                    )),
              );
            },
          ),
          ListTile(
            title: const Text('إدارة الخصومات والعروض'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OffersDiscountsManagementScreen(
                      title: 'إدارة الخصومات والعروض',
                    )),
              );
            },
          ),
          ListTile(
            title: const Text('دعم العملاء'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CustomerSupportManagementScreen(
                      title: 'دعم العملاء',
                    )),
              );
            },
          ),
        ],
      ),
    );
  }
}
