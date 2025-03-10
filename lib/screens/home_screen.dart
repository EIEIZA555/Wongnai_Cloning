import 'dart:math'; // ✅ ใช้สำหรับสุ่มร้านอาหาร
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
  List<Map<String, dynamic>> recommendedRestaurants = [];

  @override
  void initState() {
    super.initState();
    getRandomRestaurants(); // ✅ สุ่มร้านอาหารแนะนำตอนเริ่มแอป
  }

  /// ✅ ฟังก์ชันสุ่มร้านแนะนำ 5 ร้าน (ใช้ได้เฉพาะส่วน "ร้านอาหารแนะนำ")
  void getRandomRestaurants() {
    final random = Random();
    List<Map<String, dynamic>> shuffled = List.from(allRestaurants)..shuffle(random);
    setState(() {
      recommendedRestaurants = shuffled.take(5).toList();
    });
  }

  /// ✅ ฟังก์ชันกรองร้านอาหารตามหมวดหมู่ที่เลือก
  List<Map<String, dynamic>> getFilteredRestaurants() {
    return allRestaurants.where((restaurant) {
      final matchesCategory = selectedCategory == "ทั้งหมด" ||
          restaurant["category"] == selectedCategory;
      final matchesSearch =
          restaurant["name"].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

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

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredRestaurants = getFilteredRestaurants(); // ✅ กรองร้านอาหารตามหมวดหมู่

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
            SizedBox(height: 10),

            /// ✅ แสดง "ร้านอาหารแนะนำ" (สุ่ม 5 ร้าน)
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
                children: recommendedRestaurants.map((restaurant) {
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
            SizedBox(height: 20),
            RestaurantCategoryWidget(
              categories: ["ทั้งหมด", "ชาบู", "อาหารจานด่วน", "สเต็ก", "ปิ้งย่าง", "กาแฟ/ของหวาน"],
              selectedCategory: selectedCategory,
              onCategorySelected: updateCategory,
            ),
            SizedBox(height: 10),
            /// ✅ แสดงร้านอาหารที่ "กรองแล้ว" ตามหมวดหมู่ที่เลือก
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "ร้านอาหาร (${selectedCategory == "ทั้งหมด" ? "ทั้งหมด" : selectedCategory})",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredRestaurants.length,
              itemBuilder: (context, index) {
                var restaurant = filteredRestaurants[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailScreen(restaurant: restaurant),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          restaurant["image"],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(restaurant["name"]),
                      subtitle: Text("⭐ ${restaurant["rating"]} - ${restaurant["location"]}"),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
                    ),
                  ),
                );
              },
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
