import 'package:flutter/material.dart';

class RestaurantListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> restaurants;
  final String searchQuery; // รับค่าค้นหาจาก HomeScreen

  const RestaurantListWidget({
    super.key,
    required this.restaurants,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    // กรองร้านอาหารตาม searchQuery
    final filteredRestaurants = restaurants.where((restaurant) {
      final name = restaurant["name"].toLowerCase();
      return name.contains(searchQuery.toLowerCase());
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: filteredRestaurants.map((restaurant) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(restaurant["image"] ?? ""),
            ),
            title: Text(restaurant["name"], style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("⭐ ${restaurant["rating"]} - ${restaurant["location"]}"),
          ),
        );
      }).toList(),
    );
  }
}
