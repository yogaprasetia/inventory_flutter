import 'package:flutter/material.dart';
import 'package:qrcode_bloc/bloc/bloc.dart';
import 'package:qrcode_bloc/routes/router.dart';

class AddProducts extends StatelessWidget {
  AddProducts({super.key});
  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            maxLength: 10,
            autocorrect: false,
            controller: codeC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Product Code",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                )),
          ),
          const SizedBox(height: 20),
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
              if (codeC.text.length == 10) {
                context.read<ProductBloc>().add(ProductEventAddProduct(
                    code: codeC.text,
                    name: nameC.text,
                    qty: int.tryParse(qtyC.text) ?? 0,
                  ));
              } else {
                ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Kode Produk Wajib 10 Karakter")));
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)),
            ),
            child: BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is ProductStateError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
                if (state is ProductStateComplete) {
                  context.pop();
                }
              },
              builder: (context, state) {
                return Text(state is ProductStateLoading
                    ? "LOADING..."
                    : "Tambah Produk");
              },
            ),
          )
        ],
      ),
    );
  }
}
