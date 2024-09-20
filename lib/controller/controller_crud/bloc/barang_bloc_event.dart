part of 'barang_bloc_bloc.dart';

sealed class BarangBlocEvent extends Equatable {
  const BarangBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchBarangEvent extends BarangBlocEvent{}

class CreateBarangEvent extends BarangBlocEvent{
  final String namaBarang;
  final String brandBarang;
  final String warna;
  final String imgBarang;

  const CreateBarangEvent({
    required this.namaBarang,
    required this.brandBarang,
    required this.warna,
    required this.imgBarang,
  });

  @override
  List<Object> get props => [namaBarang, brandBarang, warna, imgBarang];
}

class UpdateBarangEvent extends BarangBlocEvent{
  final int barangId;
  final String namaBarang;
  final String brandBarang;
  final String warna;
  final String imgBarang;

  const UpdateBarangEvent({
    required this.barangId,
    required this.namaBarang,
    required this.brandBarang,
    required this.warna,
    required this.imgBarang,
  });

  @override
  List<Object> get props => [barangId, namaBarang, brandBarang, warna, imgBarang];
}

class DeleteBarangEvent extends BarangBlocEvent {
  final int barangId;

  const DeleteBarangEvent({required this.barangId});

  @override
  List<Object> get props => [barangId];
}