import 'package:flutter/material.dart';
import '../bloc/bloc.dart';
import 'package:qrcode_bloc/routes/router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page"),
      ),
      body: GridView.builder(
        itemCount: 4,
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
        itemBuilder: (context, index) {
          late String title;
          late IconData icon;
          late VoidCallback onTap;

          switch (index) {
            case 0:
              title = "Add Products";
              icon = Icons.post_add_rounded;
              onTap = () => context.goNamed(Routes.addProduct);
              break;
            case 1:
              title = "Products";
              icon = Icons.list_alt_outlined;
              onTap = () => context.goNamed(Routes.products);
              break;
            case 2:
              title = "QR Code";
              icon = Icons.qr_code;
              onTap = () {};
              break;
            case 3:
              title = "Catalog";
              icon = Icons.document_scanner_outlined;
              onTap = () {};
              break;
            default:
          }
          return Material(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(9),
            child: InkWell(
              onTap: onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: Icon(
                        icon,
                        size: 50,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(title),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AuthBloc>().add(AuthEventLogout());
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
