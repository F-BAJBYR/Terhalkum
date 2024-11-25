import 'dart:convert'; // Needed for JSON decoding
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EntitiesEstablishmentsManagementScreen extends StatelessWidget {
  const EntitiesEstablishmentsManagementScreen({super.key, required this.title});
  final String title;

  // دالة لجلب البيانات من API PHP
  Future<List<dynamic>> fetchEstablishments() async {
    final response = await http.get(Uri.parse('https://127.0.0.1/api/get_establishments.php'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load establishments');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الجهات والمنشئات'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'الجهات والمنشئات',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: fetchEstablishments(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Text('حدث خطأ أثناء جلب البيانات');
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('لا توجد جهات أو منشئات حاليًا');
                  }

                  var establishments = snapshot.data!;

                  return ListView.builder(
                    itemCount: establishments.length,
                    itemBuilder: (context, index) {
                      var establishment = establishments[index];

                      return EstablishmentCard(establishment: establishment);
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

class EstablishmentCard extends StatelessWidget {
  final Map<String, dynamic> establishment;

  const EstablishmentCard({super.key, required this.establishment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(Icons.business, color: Colors.purple),
        title: Text(establishment['name']),
        subtitle: Text(establishment['location']),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EstablishmentDetailScreen(establishmentId: establishment['id'].toString()),
            ),
          );
        },
      ),
    );
  }
}

class EstablishmentDetailScreen extends StatelessWidget {
  final String establishmentId;

  const EstablishmentDetailScreen({super.key, required this.establishmentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل المنشأة'),
      ),
      body: Center(
        child: Text('Details for establishment ID: $establishmentId'),
      ),
    );
  }
}
