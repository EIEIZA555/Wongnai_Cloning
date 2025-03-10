import 'package:flutter/material.dart';
import '../screens/category_screen.dart';

class CategoryMenuWidget extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.restaurant, "label": "ร้านอาหาร"},
    {"icon": Icons.local_cafe, "label": "กาแฟ/ของหวาน"},
    {"icon": Icons.fastfood, "label": "ร้านอาหารจานด่วน"},
  ];

  CategoryMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryScreen(category: category["label"]),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFA726), // ✅ สีส้ม Wongnai
                      shape: BoxShape.circle,
                    ),
                    child: Icon(category["icon"], size: 30, color: Colors.white),
                  ),
                ),
                SizedBox(height: 5),
                Text(category["label"], style: TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }
}
