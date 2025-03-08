import 'package:flutter/material.dart';

class RestaurantGridWidget extends StatelessWidget {
  final List<Map<String, dynamic>> restaurants = [
    {
      "name": "Thong Grill Hide & Shabu",
      "image": "assets/images/thonggrill.png",
      "type": "ชาบู/สุกี้ยากี้/หม้อไฟ",
      "rating": 4.1,
      "reviews": 6
    },
    {
      "name": "The Saucy Kitchen",
      "image": "assets/images/saucy_kitchen.png",
      "type": "อาหารคลีน/สลัด",
      "rating": 4.1,
      "reviews": 6
    },
    {
      "name": "Burger King",
      "image": "assets/images/burger_king.png",
      "type": "ฟาสต์ฟู้ด/จานด่วน, เบอร์เกอร์",
      "rating": 4.1,
      "reviews": 6
    },
    {
      "name": "MOS BURGER",
      "image": "assets/images/mos_burger.png",
      "type": "เบอร์เกอร์",
      "rating": 4.5,
      "reviews": 8
    },
  ];

  final List<Map<String, dynamic>> vibes = [
    {
      "name": "Fashion Island",
      "image": "assets/images/fashion_island.png",
      "location": "รามอินทรา"
    },
    {
      "name": "Centra Ladprao",
      "image": "assets/images/centra_ladprao.png",
      "location": "ลาดพร้าว"
    },
    {
      "name": "The Mall Bangkapi",
      "image": "assets/images/the_mall_bangkapi.png",
      "location": "บางกะปิ"
    },
  ];

  RestaurantGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Section: ร้านอาหาร (แบบ Grid)
          _buildRestaurantSection(),

          SizedBox(height: 20),

          // 🔹 Section: Vibes
          _buildVibesSection(),
        ],
      ),
    );
  }

  // 🔹 Section: ร้านอาหาร
  Widget _buildRestaurantSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("แนะนำสำหรับคุณ"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: restaurants.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return _buildRestaurantCard(restaurants[index]);
            },
          ),
        ),
      ],
    );
  }

  // 🔹 Section: Vibes
  Widget _buildVibesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("#Vibes"),
        SizedBox(height: 8),
        Container(
          height: 140, // ปรับให้เลื่อนได้แนวนอน
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: vibes.length,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return _buildVibeCard(vibes[index]);
            },
          ),
        ),
      ],
    );
  }

  // 🔹 หัวข้อ Section
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 🔹 การ์ดร้านอาหาร (แบบ Grid 2 แถว)
  Widget _buildRestaurantCard(Map<String, dynamic> restaurant) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 1.6,
              child: Image.asset(
                restaurant["image"],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant["name"],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  restaurant["type"],
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.white, size: 12),
                          SizedBox(width: 4),
                          Text(
                            "${restaurant["rating"]}",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "${restaurant["reviews"]} รีวิว",
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 การ์ด Vibes (แนวนอน)
  Widget _buildVibeCard(Map<String, dynamic> vibe) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 1.4,
              child: Image.asset(
                vibe["image"],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vibe["name"],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  vibe["location"],
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
