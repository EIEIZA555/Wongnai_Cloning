import 'package:flutter/material.dart';

class RestaurantCategoryWidget extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const RestaurantCategoryWidget({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;
          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orange),
              ),
              alignment: Alignment.center, // จัดให้ข้อความอยู่กึ่งกลาง
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // ให้ข้อความอยู่ตรงกลาง
              ),
            ),
          );
        },
      ),
    );
  }
}