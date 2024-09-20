import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockwatch_app/controller/controller_user/bloc/user_bloc_bloc.dart';
import 'package:stockwatch_app/views/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: BlocListener<UserBlocBloc, UserBlocState>(
        listener: (context, state) {
          if (state is UserBlocLoaded) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false,
            );
          } else if (state is UserBlocError) {
            // Tampilkan error jika login gagal
            print('Registration error: ${state.message}');
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<UserBlocBloc, UserBlocState>(
          builder: (context, state) {
            if (state is UserBlocLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Trigger event login ketika tombol ditekan
                      context.read<UserBlocBloc>().add(RegisterUser(
                          username: _usernameController.text,
                          email: _emailController.text,
                          password: _passwordController.text));
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
