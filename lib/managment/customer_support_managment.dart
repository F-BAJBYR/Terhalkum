import 'dart:convert'; // Needed for JSON decoding
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomerSupportManagementScreen extends StatelessWidget {
  const CustomerSupportManagementScreen({super.key, required this.title});
  final String title;

  // دالة لجلب البيانات من API PHP
  Future<List<dynamic>> fetchSupportTickets() async {
    final response = await http.get(Uri.parse('https://127.0.0.1/api/get_support_tickets.php'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load support tickets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة دعم العملاء'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'طلبات دعم العملاء',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: fetchSupportTickets(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Text('حدث خطأ أثناء جلب البيانات');
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('لا توجد طلبات دعم حاليًا');
                  }

                  var tickets = snapshot.data!;

                  return ListView.builder(
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      var ticket = tickets[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: const Icon(Icons.support_agent, color: Colors.purple),
                          title: Text('الطلب: ${ticket['title']}'),
                          subtitle: Text('الحالة: ${ticket['status']}'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomerSupportDetailScreen(ticketId: ticket['id'].toString())),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerSupportDetailScreen extends StatelessWidget {
  final String ticketId;

  const CustomerSupportDetailScreen({super.key, required this.ticketId});

  Future<Map<String, dynamic>> fetchTicketDetails() async {
    final response = await http.get(Uri.parse('https://127.0.0.1/api/get_ticket_details.php?ticket_id=$ticketId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load ticket details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الطلب'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchTicketDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Text('حدث خطأ أثناء جلب التفاصيل');
          }

          if (!snapshot.hasData) {
            return const Text('لا توجد بيانات');
          }

          var ticketData = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'العميل: ${ticketData['customerName']}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'البريد الإلكتروني: ${ticketData['email']}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                const Text(
                  'تفاصيل الطلب:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  ticketData['description'],
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // استدعاء API آخر لتحديث حالة الطلب
                      http.post(Uri.parse('https://127.0.0.1/api/update_ticket_status.php'),
                          body: {'ticket_id': ticketId, 'status': 'Resolved'});

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم معالجة الطلب')),
                      );

                      Navigator.pop(context);
                    },
                    child: const Text('حل المشكلة'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
