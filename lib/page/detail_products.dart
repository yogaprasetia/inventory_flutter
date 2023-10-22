import 'package:flutter/material.dart';

class DetailProducts extends StatelessWidget {
  const DetailProducts(this.id, this.data, {super.key});

  final String id;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Product"),
      ),
      body: Center(
        child: Text(data.toString()),
      ),
    );
  }
}
