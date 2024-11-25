import 'package:flutter/material.dart';
import 'package:terhalkum/Authentication/new-password.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('إعادة تعيين كلمة المرور'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'أدخل كلمة مرور جديدة، وتأكد من تذكرها هذه المرة.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'كلمة المرور الجديدة',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'تأكيد كلمة المرور',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // عرض نجاح إعادة تعيين كلمة المرور
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PasswordResetSuccessScreen()),
                  );
                },
                child: const Text('إعادة تعيين كلمة المرور'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

