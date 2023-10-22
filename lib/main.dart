import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qrcode_bloc/bloc/auth/auth_bloc.dart';
import 'firebase_options.dart';
import './routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}
