import 'package:flutter/material.dart';
import 'package:qrcode_bloc/routes/router.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              context.goNamed(Routes.detailProduct,
                  pathParameters: {"id": "${index + 1}"},
                  queryParameters: {
                    "id" : "${index + 1}",
                    "titile" : "Title ${index + 1}",
                    "deskripsi" : "Deskripsi produk ${index + 1}"
                  });
            },
            leading: CircleAvatar(
              child: Text("${index + 1}"),
            ),
            title: Text("PRODUCT ${index + 1}"),
            subtitle: Text("DESKRIPSI ${index + 1}"),
          );
        },
      ),
    );
  }
}
