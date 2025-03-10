import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BenefitsWidget extends StatelessWidget {
  final List<Map<String, String>> benefits = [
    {
      "title": "ส่วนลดพิเศษ",
      "image": "assets/images/discount.png",
      "description": "ส่วนลดสูงสุด 50% อร่อยคุ้มได้มากกว่า",
      "url": "https://www.wongnai.com/campaigns/ttb?regionId=9681&regions=9681"
    },
    {
      "title": "ส่วนลดพิเศษ",
      "image": "assets/images/discount2.png",
      "description": "ลดสูงสุด 10% มื้อนี้มีส่วนลด ด้วยบัตรเครดิตธนาคารออมสิน",
      "url": "https://www.wongnai.com/campaigns/gsb?regionId=9681&regions=9681"
    },
    {
      "title": "ส่วนลดพิเศษ",
      "image": "assets/images/discount3.png",
      "description": "ลด 40% กับบัตรเครดิต UOB มากกว่า 2,000 ร้านอาหารชั้นนำ",
      "url": "https://www.wongnai.com/campaigns/UOB?regionId=9681&regions=9681"
    },
    {
      "title": "กิจกรรม",
      "image": "assets/images/prize1.jpg",
      "description": "แจก 100 รางวัล #WONGNAI2025",
      "url": "https://www.wongnai.com/blogs/wongnai-2025"
    },
  ];

  /// ✅ ฟังก์ชันเปิดเว็บลิงก์
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            "สิทธิประโยชน์พิเศษ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: benefits.length,
            itemBuilder: (context, index) {
              var benefit = benefits[index];
              return GestureDetector(
                onTap: () {
                  _launchURL(benefit["url"]!); // ✅ กดแล้วเปิดเว็บ
                },
                child: Container(
                  width: 150,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(benefit["image"]!, height: 80),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(
                              benefit["title"]!,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              benefit["description"]!,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
