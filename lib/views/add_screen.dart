import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockwatch_app/views/home_screen.dart';

import '../controller/controller_crud/bloc/barang_bloc_bloc.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _namaController = TextEditingController();
    final TextEditingController _brandController = TextEditingController();
    final TextEditingController _warnaController = TextEditingController();
    final TextEditingController _imgController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Add Barang')),
      body: BlocListener<BarangBlocBloc, BarangBlocState>(
        listener: (context, state) {
          if (state is CUDBlocSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false,
            );
          } else if (state is CUDBlocError) {
            // Tampilkan error jika login gagal
            print('Registration error: ${state.error}');
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<BarangBlocBloc, BarangBlocState>(
          builder: (context, state) {
            if (state is CUDBlocLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _namaController,
                    decoration: const InputDecoration(labelText: 'nama barang'),
                  ),
                  TextField(
                    controller: _brandController,
                    decoration:
                        const InputDecoration(labelText: 'brand barang'),
                  ),
                  TextField(
                    controller: _warnaController,
                    decoration: const InputDecoration(labelText: 'warna'),
                    
                  ),
                  TextField(
                    controller: _imgController,
                    decoration: const InputDecoration(labelText: 'image'),
                    
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Trigger event login ketika tombol ditekan
                      context.read<BarangBlocBloc>().add(CreateBarangEvent(
                        
                            namaBarang: _namaController.text,
                            brandBarang: _brandController.text,
                            warna: _warnaController.text,
                            imgBarang: _imgController.text,
                          ));
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
