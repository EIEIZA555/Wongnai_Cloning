import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class CarouselSliderWidget extends StatelessWidget {
  final List<Map<String, String>> banners = [
    {
      "image": "assets/images/banner1.jpg",
      "url": "https://www.wongnai.com/blogs/wongnaixwhoscall",
    },
    {
      "image": "assets/images/banner2.jpg",
      "url": "https://www.lmwnmerchantcenter.com/foodstory-pos-classroom",
    },
    {
      "image": "assets/images/banner3.jpg",
      "url": "https://www.wongnai.com/business-owners/lineman-half-half-manual-guide",
    },
  ];

  CarouselSliderWidget({super.key});

  /// ✅ ฟังก์ชันเปิดลิงก์ในเบราว์เซอร์
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
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: banners.map((banner) {
        return GestureDetector(
          onTap: () {
            _launchURL(banner["url"]!); // ✅ กดแล้วเปิดเว็บ
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              banner["image"]!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        );
      }).toList(),
    );
  }
}
