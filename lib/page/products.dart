import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qrcode_bloc/bloc/bloc.dart';
import 'package:qrcode_bloc/models/product.dart';
import 'package:qrcode_bloc/routes/router.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductBloc productB = context.read<ProductBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
      ),
      body: StreamBuilder<QuerySnapshot<Product>>(
        stream: productB.streamProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text("Tidak ada data."),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Tidak dapat memuat data"),
            );
          }

          List<Product> allProduct = [];

          for (var element in snapshot.data!.docs) {
            allProduct.add(element.data());
          }

          if (allProduct.isEmpty) {
            return const Center(
              child: Text("Tidak ada data"),
            );
          }
          
          return ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: allProduct.length,
            itemBuilder: (context, index) {
              Product product = allProduct[index];
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)
                ),
                margin: EdgeInsets.only(bottom: 20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(9),
                  onTap: () {
                    context.goNamed(
                      Routes.detailProduct,
                      pathParameters: {
                        "id" : product.productId!,

                      },
                      extra: product,

                      );
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    height: 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.code!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5,),
                              Text(product.name!),
                              Text("Jumlah Produk : ${product.qty}"),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          child: QrImageView(
                            data: product.code!,
                            size: 200.0,
                            version: QrVersions.auto,
                            ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
