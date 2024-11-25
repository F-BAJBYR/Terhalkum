import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:terhalkum/pages/TrhAlkM-1.dart';

void main() {
  runApp(const TrhAlkM());
}

class TrhAlkM extends StatelessWidget {
  const TrhAlkM({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set the direction to RTL globally
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildCategoryButtons(context),
                _buildHeroBanner(),
                _buildTripPackagesSection(context),
                _buildPackagesList(context),
                _buildRecommendationsSection(),
                _buildRecommendationList(),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(),
        ),
      ),
    );
  }

  Widget _buildCategoryButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          categoryButton(Icons.hotel, 'السكن', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TrhAlkM1()), // Navigate to TrhAlkM-1.dart screen
            );
          }),
          categoryButton(Icons.credit_card, 'الباقات', () {
               MaterialPageRoute(builder: (context) => const TrhAlkM());  // Define another action or screen navigation if necessary.
          }),
        ],
      ),
    );
  }

  Widget categoryButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 40, color: const Color.fromARGB(255, 103, 39, 176)),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: NetworkImage(
              'https://safarin.net/wp-content/uploads/2017/11/17-11-03_10-38-37.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              'استكشف أفضل المعالم مع باقاتنا المميزة',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTripPackagesSection(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'احجز باقة رحلة احلامك',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackagesList(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchPackages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('خطأ: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('لا توجد بيانات');
        } else {
          return SizedBox(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.map((package) {
                return _buildTripPackageCard(
                  context,
                  package['name'],
                  package['imageUrl'],
                  package['price'],
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }

  Widget _buildTripPackageCard(
      BuildContext context, String title, String imageUrl, int price) {
    return GestureDetector(
      onTap: () {
        // تفاصيل الباقة عند الضغط
      },
      child: tripPackageCard(title, imageUrl, price),
    );
  }

  Widget tripPackageCard(String title, String imageUrl, int price) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$title - SR$price',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 250, 250, 250),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  child: const Text(
                    'أعرض الباقة',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color.fromARGB(255, 101, 37, 154),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchPackages() async {
    final response =
        await http.get(Uri.parse('http://localhost/get_packages.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('فشل في تحميل الباقات');
    }
  }

  Widget _buildRecommendationsSection() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'التوصيات',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: const Color(0xFF6F35A5),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'الصفحة الرئيسية',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'الحجوزات',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'الحساب',
        ),
      ],
    );
  }

  Widget _buildRecommendationList() {
    return const Text('Recommendations go here');
  }
}
