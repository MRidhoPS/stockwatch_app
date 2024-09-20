import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockwatch_app/controller/controller_crud/bloc/barang_bloc_bloc.dart';
import 'package:stockwatch_app/controller/controller_user/bloc/user_bloc_bloc.dart';
import 'package:stockwatch_app/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBlocBloc>(
          create: (context) => UserBlocBloc(),
        ),
        BlocProvider(
          create: (context) => BarangBlocBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
