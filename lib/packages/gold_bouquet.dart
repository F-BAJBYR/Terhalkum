import 'package:terhalkum/packages/PackageCustomizationScreen.dart';
import 'package:flutter/material.dart';

class GoldBouquet extends StatelessWidget {
  final String packageName;
  final int price;

  const GoldBouquet(
      {super.key, required this.packageName, required this.price});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Make all text RTL globally
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
                    'https://cdn.pixabay.com/photo/2012/02/21/07/26/al-abrar-mecca-15077_1280.jpg',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // Package Name and Price
                  Positioned(
                    bottom: 10,
                    right: 16, // Align text to the right
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end, // Align text content
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
                    '3رحلات(برية و من المناطق التاريخية والتراثية)'),
                    _buildFeatureItem('حجز مطعم'),
                    _buildFeatureItem('مرشد سياحي'),
                    _buildFeatureItem('مواصلات'),
                    const SizedBox(height: 16),
                    const Text(
                      'عدد الأيام: 3 أيام',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    // Image gallery using network images
                    Row(
                      children: [
                        Expanded(
                          child: Image.network(
                              'https://vid.alarabiya.net/images/2017/02/07/12042570-478c-4a58-9c21-adb979a92e5a/12042570-478c-4a58-9c21-adb979a92e5a.jpg',
                              height: 100,
                              fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Image.network(
                              'https://th.bing.com/th/id/R.288d326ebf66f9e29901ef8bd33c67ac?rik=wKlCKNOCPc6iLw&riu=http%3a%2f%2fbestoffers.travel%2fUploadFiles%2fNews%2fghar-hira.jpg&ehk=fCeiCyHOWZ%2fjTHklPAmmcPzWSOtTZdDV4exGYrP9Azk%3d&risl=&pid=ImgRaw&r=0',
                              height: 100,
                              fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Image.network(
                              'https://th.bing.com/th/id/R.0e65de74e8204c6bf46fae2f43ec98bc?rik=TxdA86yMMX3MNQ&riu=http%3a%2f%2fmhdassaf.com%2fdata%2fe5d11-019-.jpg&ehk=pVJHxljiNW7yYSKs209K7QNcY4sAIJ8fMk7BLO73ypU%3d&risl=&pid=ImgRaw&r=0',
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
                              fontSize: 18, // Customize the font size
                              fontWeight:
                              FontWeight.bold, // Set the font weight to bold
                              color: Colors
                                  .white, // Set text color to white for contrast
                            ),
                          ),
                        ),
                        Text(
                          'SR $price/شخص', // Use the price variable here
                          style: const TextStyle(
                            fontSize: 18, // Customize the font size
                            fontWeight: FontWeight.bold, // Bold text for emphasis
                            color: Colors.black, // Default color
                          ),
                        ),
                      ],
                    )
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
