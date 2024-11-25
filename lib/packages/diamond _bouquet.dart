import 'package:terhalkum/packages/PackageCustomizationScreen.dart';
import 'package:flutter/material.dart';

class DiamondBouquet extends StatelessWidget {
  final String packageName;
  final int price;

  const DiamondBouquet(
      {super.key, required this.packageName, required this.price});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set global RTL text direction
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // Top Image using network
                  Image.network(
                    'https://th.bing.com/th/id/R.48fb48a6c5e8d8f6e0739ef446061fbf?rik=ByWotbRahfuk6A&riu=http%3a%2f%2f2.bp.blogspot.com%2f-Z-R4nnH1mmE%2fUJFDfzE_DbI%2fAAAAAAAAFtk%2fsMHgoannDV4%2fs1600%2fMasjid%2bNabawi.jpg&ehk=R9gZtAiTKhgjXwU1TUf4OAuswnf9Va5JvpAQsIZncqQ%3d&risl=&pid=ImgRaw&r=0',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // Package Name and Price
                  Positioned(
                    bottom: 10,
                    right: 16, // Align text to the right
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end, // Right-aligned text
                      children: [
                        Text(
                          'SR $price',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 107, 33, 243),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          packageName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Details Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'الوصف',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'باقة السفر هذه تقدم لك مجموعة من الخدمات التي تجعل رحلتك أكثر راحة وتنظيماً.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'يشمل الحجز',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    _buildFeatureItem(
                  '5رحلات(برية و من المناطق التاريخية والتراثية)'),
                    _buildFeatureItem('حجز مطعم'),
                    _buildFeatureItem('مرشد سياحي'),
                    _buildFeatureItem('مواصلات'),
                    const SizedBox(height: 16),
                    const Text(
                      'عدد الأيام: 5 أيام',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    // Image gallery using network images
                    Row(
                      children: [
                        Expanded(
                          child: Image.network(
                              'https://th.bing.com/th/id/OIP.eu0JAPhs5GOGd3ezI2mK5gHaEU?rs=1&pid=ImgDetMain',
                              height: 100,
                              fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Image.network(
                              'https://th.bing.com/th/id/OIP.TfTq3QbGBEdZ0p3cQjaEHQHaDh?rs=1&pid=ImgDetMain',
                              height: 100,
                              fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Image.network(
                              'https://th.bing.com/th/id/OIP.N20l20bNXrr8MW2TiGDQqAHaDt?rs=1&pid=ImgDetMain',
                              height: 100,
                              fit: BoxFit.cover),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        // Implement image viewing functionality
                      },
                      child: const Text(
                        'شاهد المزيد من الصور',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Booking Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to PackageCustomizationScreen.dart
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const PackageCustomizationScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color.fromARGB(255, 94, 39, 176),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 12),
                          ),
                          child: const Text(
                            'احجز الآن',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          'SR $price/شخص', // Use the price variable here
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 8),
          Text(
            feature,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
