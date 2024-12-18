import 'dart:convert';

import 'package:credsafe/utils/common_widgets/credential_input_widget.dart';
import 'package:credsafe/utils/constants/json_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryItemsScreen extends StatelessWidget {
  final String category;
  const CategoryItemsScreen(this.category, {super.key});

  // Fetch category items from JSON
  Future<Map<String, dynamic>> loadCategoryItems() async {
    String jsonString = await rootBundle.loadString(jsonCategoriesData);
    return jsonDecode(jsonString);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category),backgroundColor: Colors.grey.shade50,),
      backgroundColor: Colors.grey.shade50,
      body: FutureBuilder<Map<String, dynamic>>(
        future: loadCategoryItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading category items"));
          } else {
            var categoryItems = snapshot.data?['categoryItems'][category] ?? [];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categoryItems.length,
                itemBuilder: (context, index) {
                  var item = categoryItems[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to credential input page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CredentialInputScreen(item['title'],category),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(item['icon'], width: 50, height: 50), // Platform icon
                          const SizedBox(height: 10),
                          Text(
                            item['title'],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}