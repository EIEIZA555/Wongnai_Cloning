import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RestaurantDetailScreen extends StatefulWidget {
  final Map<String, dynamic> restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  _RestaurantDetailScreenState createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  List<Map<String, dynamic>> reviews = [];
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 5.0;

  @override
  void initState() {
    super.initState();
    loadReviews();
  }

  /// ✅ โหลดรีวิวจาก SharedPreferences
  Future<void> loadReviews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = "reviews_${widget.restaurant['name']}";
    String? savedReviews = prefs.getString(key);

    if (savedReviews != null) {
      setState(() {
        reviews = List<Map<String, dynamic>>.from(json.decode(savedReviews));
      });
    }
  }

  /// ✅ บันทึกรีวิวลง SharedPreferences
  Future<void> saveReviews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = "reviews_${widget.restaurant['name']}";
    await prefs.setString(key, json.encode(reviews));
  }

  /// ✅ ฟังก์ชันเพิ่มรีวิวใหม่
  void addReview() {
    if (_reviewController.text.isNotEmpty) {
      setState(() {
        reviews.add({
          "user": "Guest",
          "rating": _rating,
          "comment": _reviewController.text,
        });
      });

      saveReviews(); // ✅ บันทึกลง SharedPreferences
      _reviewController.clear();
      setState(() {
        _rating = 5.0; // รีเซ็ตคะแนน
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant["name"], style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF1A237E), // ✅ สีธีม Wongnai (น้ำเงินเข้ม)
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.restaurant["image"], width: double.infinity, height: 200, fit: BoxFit.cover),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.restaurant["name"], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("⭐ ${widget.restaurant["rating"]} - ${widget.restaurant["location"]}", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                  SizedBox(height: 16),
                  Text(widget.restaurant["description"], style: TextStyle(fontSize: 16)),
                ],
              ),
            ),

            /// ✅ แสดงเมนูอาหารถ้ามี
            if (widget.restaurant.containsKey("menuImages"))
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("เมนูแนะนำ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: (widget.restaurant["menuImages"] as List<String>).map((image) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(image, width: 120, height: 120, fit: BoxFit.cover),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),

            /// ✅ ฟอร์มเพิ่มรีวิว
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("เขียนรีวิว", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("ให้คะแนน: ", style: TextStyle(fontSize: 16)),
                      DropdownButton<double>(
                        value: _rating,
                        items: [1, 2, 3, 4, 5].map((e) {
                          return DropdownMenuItem<double>(
                            value: e.toDouble(),
                            child: Text("$e ดาว"),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _rating = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  TextField(
                    controller: _reviewController,
                    decoration: InputDecoration(
                      hintText: "พิมพ์รีวิวของคุณ...",
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: addReview,
                    child: Text("ส่งรีวิว"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            /// ✅ แสดงรีวิวจากผู้ใช้
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("รีวิวจากผู้ใช้", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            if (reviews.isEmpty)
              Center(child: Text("ยังไม่มีรีวิว", style: TextStyle(fontSize: 16, color: Colors.grey)))
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  var review = reviews[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(review["user"], style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(review["comment"]),
                      trailing: Text("⭐ ${review["rating"]}"),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
