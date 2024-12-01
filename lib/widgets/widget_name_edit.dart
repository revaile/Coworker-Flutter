import 'package:flutter/material.dart';

class NameInput extends StatelessWidget {
  final String title;
  final String name;

  const NameInput({
    Key? key,
    required this.title,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black, // Warna teks hitam
            ),
          ),
          TextFormField(
            // Styling warna teks inputan
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black, // Warna teks inputan hitam
            ),
            decoration: InputDecoration(
              // Styling hint text
              hintText: name,
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Colors.black, // Warna hint teks hitam
              ),
              // Styling border ketika tidak aktif
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black, // Warna border hitam
                ),
              ),
              // Styling border ketika aktif
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black, // Warna border hitam saat fokus
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
