import 'dart:convert'; // Needed for json decoding
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatelessWidget {
  final String title;

  const DashboardScreen({super.key, required this.title});

  // دالة لجلب البيانات من API الذي يتصل بقاعدة البيانات
  Future<List<dynamic>> fetchDashboardData() async {
    final response = await http.get(Uri.parse('https://127.0.0.1/api/get_dashboard_data.php')); // تأكد من وضع رابط API الصحيح

    if (response.statusCode == 200) {
      // فك تشفير JSON وتحويله إلى List
      return json.decode(response.body);
    } else {
      // التعامل مع الأخطاء في حالة حدوثها
      throw Exception('Failed to load dashboard data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder<List<dynamic>>(
        future: fetchDashboardData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          var dashboardData = snapshot.data!;

          return ListView.builder(
            itemCount: dashboardData.length,
            itemBuilder: (context, index) {
              var data = dashboardData[index];
              return DashboardCard(data: data);
            },
          );
        },
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final Map<String, dynamic> data; // البيانات على شكل Map

  const DashboardCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(data['title']), // عرض العنوان
        subtitle: Text(data['description']), // عرض الوصف
      ),
    );
  }
}
