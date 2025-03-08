import 'package:flutter/material.dart';

class CategoryMenuWidget extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.restaurant, "label": "ร้านอาหาร"},
    {"icon": Icons.local_cafe, "label": "กาแฟ/ของหวาน"},
    {"icon": Icons.place, "label": "ที่เที่ยว"},
    {"icon": Icons.delivery_dining, "label": "เดลิเวอรี"},
    {"icon": Icons.shopping_bag, "label": "สั่งไว้รับเลย"},
    {"icon": Icons.fastfood, "label": "อาหารจานด่วน"},
    {"icon": Icons.local_bar, "label": "บาร์และสถานบันเทิง"},
    {"icon": Icons.hotel, "label": "โรงแรม"},
  ];

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
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(category["icon"], size: 30, color: Colors.orange),
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
