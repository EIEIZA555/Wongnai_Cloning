import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearch; // Callback สำหรับส่งค่าค้นหา

  const SearchBarWidget({super.key, required this.onSearch});

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  void _onTextChanged(String value) {
    widget.onSearch(value); // ส่งค่าค้นหากลับไปที่ HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: _controller,
        onChanged: _onTextChanged,
        decoration: InputDecoration(
          hintText: 'ค้นหาร้านอาหาร...',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
