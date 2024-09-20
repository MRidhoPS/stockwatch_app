import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockwatch_app/controller/controller_crud/bloc/barang_bloc_bloc.dart';
import 'package:stockwatch_app/model/user_model.dart';
import 'package:stockwatch_app/views/add_screen.dart';
import 'package:stockwatch_app/views/edit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: BlocProvider(
        create: (context) => BarangBlocBloc()..add(FetchBarangEvent()),
        child: BlocBuilder<BarangBlocBloc, BarangBlocState>(
          builder: (context, state) {
            if (state is BarangBlocLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BarangBlocLoaded) {
              final barangList = state.barang;
              return ListView.builder(
                itemCount: barangList.length,
                itemBuilder: (context, index) {
                  final barang = barangList[index];
                  return ListTile(
                    title: Text(barang.namaBarang),
                    subtitle: Text(barang.brandBarang),
                    leading: IconButton(
                        onPressed: () {
                          // if (barang.barangId != null) {
                          //   context.read<BarangBlocBloc>().add(
                          //         DeleteBarangEvent(
                          //           barangId:
                          //               barang.barangId!, // Kirim barangId
                          //         ),
                          //       );
                          // }

                          context.read<BarangBlocBloc>().add(
                                DeleteBarangEvent(
                                  barangId: barang.barangId, // Kirim barangId
                                ),
                              );
                        },
                        icon: const Icon(Icons.delete_forever)),
                    // Atau sesuai dengan cara penanganan gambar
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditScreen(barang: barang),
                            ));
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  );
                },
              );
            } else if (state is BarangBlocError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('Silakan ambil barang.'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddScreen(),
              ));
        },
      ),
    );
  }
}
