import 'package:cached_network_image/cached_network_image.dart';
import 'package:credsafe/screens/dashboard/dashboard_controller.dart';
import 'package:credsafe/utils/common_widgets/categories_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
   Dashboard({super.key});
  // Create the controller instance using Get.put()
  final dashboardController = Get.put(DashboardController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey.shade50,
      ),
      backgroundColor: Colors.grey.shade50,
      body: Obx(() {
        // Use Obx to automatically rebuild the widget when the data changes
        if (dashboardController.categories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Get the categories list from the controller
        var categories = dashboardController.categories;

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              var category = categories[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to category items screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryItemsScreen(category.categoryName),
                    ),
                  );
                },
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (category.categoryLogo.contains('http') || category.categoryLogo.contains('https') ) ?
                      CachedNetworkImage(imageUrl: category.categoryLogo,width: 100,height: 100,) :
                      SvgPicture.asset(category.categoryLogo, width: 100, height: 100),
                      const SizedBox(height: 10),
                      Text(
                        category.categoryName,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}