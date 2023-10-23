import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_bloc/bloc/bloc.dart';
import 'package:qrcode_bloc/models/product.dart';
import 'package:qrcode_bloc/routes/router.dart';

class DetailProducts extends StatelessWidget {
  DetailProducts(this.id, this.product, {super.key});

  final String id;
  final Product product;
  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    codeC.text = product.code!;
    nameC.text = product.name!;
    qtyC.text = product.qty!.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Product"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: QrImageView(
                  data: product.code!,
                  size: 200,
                  version: QrVersions.auto,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            controller: codeC,
            readOnly: true,
            maxLength: 10,
            decoration: InputDecoration(
                labelText: "Kode Produk",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            controller: nameC,
            decoration: InputDecoration(
                labelText: "Nama Produk",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            controller: qtyC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Jumlah Produk",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                context.read<ProductBloc>().add(ProductEventEditProduct(
                    productId: product.productId!,
                    name: nameC.text,
                    qty: int.tryParse(qtyC.text) ?? 0,
                  ));
            },
              child: BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is ProductStateError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
                if (state is ProductStateCompleteEdit) {
                  context.pop();
                }
              },
              builder: (context, state) {
                return Text(state is ProductStateLoadingEdit
                    ? "LOADING..."
                    : "Update Produk");
              },
            ),),
          TextButton(
              onPressed: () {
                context
                    .read<ProductBloc>()
                    .add(ProductEventDeleteProduct(product.productId!));
              },
              child: BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {
                if (state is ProductStateError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
                if (state is ProductStateCompleteDelete) {
                  context.pop();
                }
              },
                builder: (context, state) {
                  return Text(state is ProductStateLoadingDelete ? "Loading..." : "Hapus Produk",
                    style: TextStyle(color: Colors.red.shade900),
                  );
                },
              ))
        ],
      ),
    );
  }
}
