import 'package:flutter/material.dart';
import '../widgets/carousel_slider.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_menu_widget.dart';
import '../widgets/restaurant_category_widget.dart';
import '../widgets/benefits_widget.dart';
import '../screens/restaurant_detail_screen.dart';
import '../data.dart'; // ✅ ใช้ข้อมูลจาก data.dart

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "ทั้งหมด";
  String searchQuery = "";

  void updateCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  /// ✅ ใช้ `allRestaurants` จาก `data.dart`
  List<Map<String, dynamic>> getFilteredRestaurants() {
    return allRestaurants.where((restaurant) {
      final matchesCategory = selectedCategory == "ทั้งหมด" ||
          restaurant["category"] == selectedCategory;
      final matchesSearch =
          restaurant["name"].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/wongnai.png', height: 40),
            SizedBox(width: 10),
            Expanded(child: SearchBarWidget(onSearch: updateSearchQuery)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            CarouselSliderWidget(),
            SizedBox(height: 20),
            CategoryMenuWidget(),
            SizedBox(height: 20),
            RestaurantCategoryWidget(
              categories: ["ทั้งหมด", "ชาบู", "ฟาสต์ฟู้ด", "สเต็ก", "ปิ้งย่าง"],
              selectedCategory: selectedCategory,
              onCategorySelected: updateCategory,
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("ร้านอาหารแนะนำ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: getFilteredRestaurants().map((restaurant) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RestaurantDetailScreen(restaurant: restaurant),
                        ),
                      );
                    },
                    child: Container(
                      width: 160,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(restaurant["image"],
                                width: 160, height: 100, fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(restaurant["name"],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Text(
                                    "⭐ ${restaurant["rating"]} - ${restaurant["location"]}",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[700])),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Divider(),
            BenefitsWidget(),
            Divider(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
