import 'package:flutter/material.dart';
import '../widgets/carousel_slider.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_menu_widget.dart';
import '../widgets/review_widget.dart';
import '../widgets/restaurant_list_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> reviews = [
    {
      "user": "Sorawit",
      "rating": 4.5,
      "comment": "แอพดี สะดวก",
    },
    {
      "user": "Kumthon",
      "rating": 4.9,
      "comment": "แอพดีแนะนำร้านเก่งมาก",
    },
  ];

  void _addReview(String user, double rating, String comment) {
    setState(() {
      reviews.add({
        "user": user,
        "rating": rating,
        "comment": comment,
      });
    });
  }

  void _removeReview(int index) {
    setState(() {
      reviews.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/wongnai.png', height: 40),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.search, color: Colors.black), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.notifications, color: Colors.black),
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.account_circle, color: Colors.black),
              onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(),
            SizedBox(height: 40),
            CarouselSliderWidget(),
            SizedBox(height: 40),
            CategoryMenuWidget(),
            RestaurantListWidget(), // ✅ ใช้ข้อมูลจากใน restaurant_list_widget.dart โดยตรง
            Divider(),
            ReviewWidget(
                reviews: reviews,
                addReview: _addReview,
                removeReview: _removeReview), // ✅ ระบบรีวิว
          ],
        ),
      ),
    );
  }
}
