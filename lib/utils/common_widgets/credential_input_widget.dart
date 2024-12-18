import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credsafe/screens/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CredentialInputScreen extends StatefulWidget {
  final String serviceName;
  final String category;

  const CredentialInputScreen(this.serviceName, this.category, {super.key});

  @override
  State<CredentialInputScreen> createState() => _CredentialInputScreenState();
}

class _CredentialInputScreenState extends State<CredentialInputScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  // Create the controller instance using Get.put()
  final dashboardController = Get.put(DashboardController());

  String categoryName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryName = dashboardController.getCollectionName(widget.category);
    log('category name in input widget $categoryName');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Credentials for ${widget.serviceName}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Username', style: TextStyle(fontSize: 18)),
            TextField(controller: _usernameController),
            const SizedBox(height: 16),
            const Text('Password', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(controller: _usernameController),
            const SizedBox(height: 16),
            TextField(controller: _usernameController),
            const SizedBox(height: 16),
            TextField(controller: _usernameController),
            ElevatedButton(
              onPressed: () {
                  log('Username: ${_usernameController.text}');
                  log('Password: ${_passwordController.text}');

                  Map<String, dynamic> categoryData = {
                    'username': _usernameController.text,
                    'password': _passwordController.text,
                    'mobile' : '',
                    'security_question' : '',
                    'category': categoryName,
                    'category_name' : widget.serviceName,
                    'created_at': FieldValue.serverTimestamp(),
                  };
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Credentials saved!')));
                  dashboardController.insertData(categoryName,categoryData);
              },
              child: const Text('Save Credentials'),
            ),
          ],
        ),
      ),
    );
  }
}