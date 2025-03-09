import 'package:flutter/material.dart';
import '../data.dart'; // ✅ ใช้ข้อมูลร้านอาหาร
import 'restaurant_detail_screen.dart'; // ✅ Import หน้า RestaurantDetailScreen

class CategoryScreen extends StatelessWidget {
  final String category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    /// ✅ กรองร้านอาหารตามหมวดหมู่
    List<Map<String, dynamic>> filteredRestaurants = allRestaurants.where((restaurant) {
      return category == "ร้านอาหาร" || restaurant["category"] == category;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category, style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF1A237E), // ✅ สีธีม Wongnai (น้ำเงินเข้ม)
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: filteredRestaurants.length,
          itemBuilder: (context, index) {
            var restaurant = filteredRestaurants[index];

            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: ListTile(
                contentPadding: EdgeInsets.all(12),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    restaurant["image"],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(restaurant["name"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                subtitle: Text("⭐ ${restaurant["rating"]} - ${restaurant["location"]}"),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
                onTap: () {
                  /// ✅ กดแล้วเปิด `RestaurantDetailScreen`
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RestaurantDetailScreen(restaurant: restaurant),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
