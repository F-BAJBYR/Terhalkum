import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OffersDiscountsManagementScreen extends StatelessWidget {
  const OffersDiscountsManagementScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة العروض والخصومات'),
      ),
      body: const OffersList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddOfferScreen(),
            ),
          );
        },
        tooltip: 'إضافة عرض جديد',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class OffersList extends StatelessWidget {
  const OffersList({super.key});

  Future<List<dynamic>> fetchOffers() async {
    final response = await http.get(Uri.parse('https://127.0.0.1/api/get_offers.php'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load offers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchOffers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('لم يتم العثور على عروض'));
        }

        final offers = snapshot.data!;

        return ListView.builder(
          itemCount: offers.length,
          itemBuilder: (context, index) {
            final offer = offers[index];
            return ListTile(
              title: Text(offer['title'] ?? 'غير معروف'),
              subtitle: Text('خصم: ${offer['discount']}%'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  deleteOffer(offer['id']);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateOfferScreen(offerId: offer['id'].toString()),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> deleteOffer(String id) async {
  if (kDebugMode) {
    print("Attempting to delete offer with ID: $id");
  }  // Log the ID
  final response = await http.post(
    Uri.parse('https://127.0.0.1/api/delete_offer.php'),
    headers: {"Content-Type": "application/x-www-form-urlencoded"},
    body: {'id': id},
  );
  if (kDebugMode) {
    print("Response: ${response.body}");
  }  // Log the response

  if (response.statusCode == 200) {
    if (kDebugMode) {
      print('تم حذف العرض');
    }
  } else {
    throw Exception('Failed to delete offer');
  }
}


}

class AddOfferScreen extends StatelessWidget {
  const AddOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final discountController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة عرض جديد'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'عنوان العرض'),
            ),
            TextField(
              controller: discountController,
              decoration: const InputDecoration(labelText: 'نسبة الخصم'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addOffer(titleController.text, double.parse(discountController.text));
                Navigator.pop(context);
              },
              child: const Text('إضافة العرض'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addOffer(String title, double discount) async {
  final response = await http.post(
    Uri.parse('https://127.0.0.1/api/add_offer.php'), // Ensure the URL is correct
    headers: {"Content-Type": "application/x-www-form-urlencoded"},
    body: {
      'title': title,
      'discount': discount.toString(),
    },
  );

  if (response.statusCode == 200) {
    print('تم إضافة العرض');
  } else {
    throw Exception('Failed to add offer');
  }
}

}

class UpdateOfferScreen extends StatelessWidget {
  final String offerId;
  const UpdateOfferScreen({super.key, required this.offerId});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final discountController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('تحديث العرض'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchOfferDetails(offerId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('لم يتم العثور على العرض'));
          }

          final offer = snapshot.data!;
          titleController.text = offer['title'];
          discountController.text = offer['discount'].toString();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'عنوان العرض'),
                ),
                TextField(
                  controller: discountController,
                  decoration: const InputDecoration(labelText: 'نسبة الخصم'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    updateOffer(offerId, titleController.text, double.parse(discountController.text));
                    Navigator.pop(context);
                  },
                  child: const Text('تحديث العرض'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchOfferDetails(String id) async {
    final response = await http.get(Uri.parse('https://127.0.0.1/api/get_offer_details.php?id=$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load offer details');
    }
  }

  Future<void> updateOffer(String id, String title, double discount) async {
    final response = await http.post(
      Uri.parse('https://127.0.0.1/api/update_offer.php'),
      body: {'id': id, 'title': title, 'discount': discount.toString()},
    );

    if (response.statusCode == 200) {
      print('تم تحديث العرض');
    } else {
      throw Exception('Failed to update offer');
    }
  }
}
