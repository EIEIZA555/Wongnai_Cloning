import 'package:flutter/material.dart';

class RestaurantListWidget extends StatefulWidget {
  @override
  _RestaurantListWidgetState createState() => _RestaurantListWidgetState();
}

class _RestaurantListWidgetState extends State<RestaurantListWidget> {
  final List<Map<String, dynamic>> allRestaurants = [
    {"name": "Katei Shabu", "image": "assets/images/katei.png", "rating": 4.5, "location": "The 4th พุทธมณฑลสาย 4"},
    {"name": "Mc Donald", "image": "assets/images/mc.jpg", "rating": 4.2, "location": "ปั้มบางจากสายไหนไม่รู้"},
    {"name": "Sizzler", "image": "assets/images/sizzler.png", "rating": 4.7, "location": "Central Salaya"},
    {"name": "Saemaeul", "image": "assets/images/saemaeul.png", "rating": 4.7, "location": "Central Nakhonprathom"},
    {"name": "KFC", "image": "assets/images/kfc.png", "rating": 4.7, "location": "Central Salaya"},
    {"name": "U&I", "image": "assets/images/youandi.png", "rating": 4.7, "location": "The Mall Lifestore Bangkae"},
  ];

  final List<Map<String, dynamic>> allVibes = [
    {"name": "ถนนสีลม", "image": "assets/images/vibe1.jpg", "location": "สีลม"},
    {"name": "Siam Paragon", "image": "assets/images/vibe2.jpg", "location": "สยาม"},
    {"name": "MSphere", "image": "assets/images/vibe3.jpg", "location": "สุขุมวิท"},
    {"name": "Fashion Island", "image": "assets/images/vibe4.jpg", "location": "รามอินทรา"},
    {"name": "Central Ladprao", "image": "assets/images/vibe5.jpg", "location": "ลาดพร้าว"},
  ];

  List<Map<String, dynamic>> filteredRestaurants = [];
  List<Map<String, dynamic>> filteredVibes = [];
  String searchCategory = "ร้านอาหาร"; // ค่าเริ่มต้น

  @override
  void initState() {
    super.initState();
    filteredRestaurants = allRestaurants;
    filteredVibes = allVibes;
  }

  void _searchItems(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredRestaurants = allRestaurants;
        filteredVibes = allVibes;
      } else {
        if (searchCategory == "ร้านอาหาร") {
          filteredRestaurants = allRestaurants.where((restaurant) {
            return restaurant["name"].toLowerCase().contains(query.toLowerCase());
          }).toList();
        } else {
          filteredVibes = allVibes.where((vibe) {
            return vibe["name"].toLowerCase().contains(query.toLowerCase());
          }).toList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown และช่องค้นหา
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              DropdownButton<String>(
                value: searchCategory,
                items: ["ร้านอาหาร", "Vibes"].map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    searchCategory = value!;
                    _searchItems(""); // รีเซ็ตผลลัพธ์
                  });
                },
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  onChanged: _searchItems,
                  decoration: InputDecoration(
                    hintText: 'ค้นหา...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Section Vibes
        if (searchCategory == "Vibes") ...[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("#Vibes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: filteredVibes.map((vibe) {
                return Container(
                  width: 160,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.asset(vibe["image"]!, width: 160, height: 100, fit: BoxFit.cover),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(vibe["name"]!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                            SizedBox(height: 4),
                            Text(vibe["location"]!, style: TextStyle(fontSize: 12, color: Colors.grey[700]), overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],

        // Section ร้านอาหาร
        if (searchCategory == "ร้านอาหาร") ...[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("แนะนำสำหรับคุณ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: filteredRestaurants.map((restaurant) {
                return Container(
                  width: 160,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.asset(restaurant["image"]!, width: 160, height: 100, fit: BoxFit.cover),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(restaurant["name"]!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                            SizedBox(height: 4),
                            Text("⭐ ${restaurant["rating"]} - ${restaurant["location"]}", style: TextStyle(fontSize: 12, color: Colors.grey[700]), overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }
}