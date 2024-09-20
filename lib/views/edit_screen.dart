import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/controller_crud/bloc/barang_bloc_bloc.dart';
import '../model/barang_model.dart';
import 'home_screen.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key, required this.barang});

  final Barang barang;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _namaController =
        TextEditingController(text: barang.namaBarang);
    final TextEditingController _brandController =
        TextEditingController(text: barang.brandBarang);
    final TextEditingController _warnaController =
        TextEditingController(text: barang.warna);
    final TextEditingController _imgController =
        TextEditingController(text: barang.imgBarang);
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Barang')),
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
                      context.read<BarangBlocBloc>().add(UpdateBarangEvent(
                            barangId: barang.barangId,
                            namaBarang: _namaController.text,
                            brandBarang: _brandController.text,
                            warna: _warnaController.text,
                            imgBarang: _imgController.text,
                          ));
                    },
                    child: const Text('Edit'),
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
