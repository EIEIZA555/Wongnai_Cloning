import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveReview(String user, double rating, String comment) async {
  await FirebaseFirestore.instance.collection('reviews').add({
    'user': user,
    'rating': rating,
    'comment': comment,
    'timestamp': FieldValue.serverTimestamp(),
  });
}


class ReviewWidget extends StatefulWidget {
  final List<Map<String, dynamic>> reviews;
  final Function(String, double, String) addReview;
  final Function(int) removeReview;

  const ReviewWidget({super.key, required this.reviews, required this.addReview, required this.removeReview});

  @override
  _ReviewWidgetState createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _showReviewDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("เพิ่มรีวิวใหม่"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "ชื่อของคุณ"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "กรุณากรอกชื่อ";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _commentController,
                  decoration: InputDecoration(hintText: "พิมพ์รีวิวของคุณ"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "กรุณากรอกความคิดเห็น";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _ratingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "ให้คะแนน (0.0 - 5.0)"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "กรุณากรอกคะแนน";
                    }
                    double? rating = double.tryParse(value);
                    if (rating == null || rating < 0.0 || rating > 5.0) {
                      return "กรุณาใส่ค่าระหว่าง 0.0 - 5.0";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("ยกเลิก"),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  double rating = double.parse(_ratingController.text);
                  widget.addReview(_nameController.text, rating, _commentController.text);
                  _nameController.clear();
                  _commentController.clear();
                  _ratingController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text("เพิ่มรีวิว"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("รีวิวจากผู้ใช้", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(icon: Icon(Icons.add, color: Colors.blue), onPressed: _showReviewDialog)
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.reviews.length,
          itemBuilder: (context, index) {
            final review = widget.reviews[index];
            return ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text(review["user"], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("⭐ ${review["rating"].toStringAsFixed(1)}"),
                  Text(review["comment"]),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => widget.removeReview(index),
              ),
            );
          },
        ),
      ],
    );
  }
}
