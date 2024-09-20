import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stockwatch_app/controller/controller_crud/crud_controller.dart';
import 'package:stockwatch_app/model/barang_model.dart';

part 'barang_bloc_event.dart';
part 'barang_bloc_state.dart';

class BarangBlocBloc extends Bloc<BarangBlocEvent, BarangBlocState> {
  BarangBlocBloc() : super(BarangBlocInitial()) {
    on<FetchBarangEvent>(_onFetchBarang);
    on<CreateBarangEvent>(_onCreateBarang);
    on<UpdateBarangEvent>(_onUpdateBarang);
    on<DeleteBarangEvent>(_onDeleteBarang);
  }

  Future<void> _onFetchBarang(
      FetchBarangEvent event, Emitter<BarangBlocState> emit) async {
    emit(BarangBlocLoading());
    try {
      final List<Barang> barangList = await CrudServices().getListBarang();
      emit(BarangBlocLoaded(barang: barangList));
    } catch (e) {
      emit(BarangBlocError(e.toString()));
    }
  }

  Future<void> _onCreateBarang(
      CreateBarangEvent event, Emitter<BarangBlocState> emit) async {
    emit(CUDBlocLoading());
    try {
      final barang = await CrudServices().createBarang(
        event.namaBarang,
        event.brandBarang,
        event.warna,
        event.imgBarang,
      );
      emit(CUDBlocSuccess('Barang created successfully: ${barang.namaBarang}'));
    } catch (e) {
      print(e);
      emit(CUDBlocError('Failed to create barang: $e'));
    }
  }

  Future<void> _onUpdateBarang(
      UpdateBarangEvent event, Emitter<BarangBlocState> emit) async {
    emit(CUDBlocLoading());
    try {
      final barang = await CrudServices().updateBarang(
        event.barangId,
        event.namaBarang,
        event.brandBarang,
        event.warna,
        event.imgBarang,
      );
      emit(CUDBlocSuccess('Barang updated successfully: ${barang.namaBarang}'));
    } catch (e) {
      emit(CUDBlocError('Failed to update barang: $e'));
    }
  }

  Future<void> _onDeleteBarang(
      DeleteBarangEvent event, Emitter<BarangBlocState> emit) async {
    emit(CUDBlocLoading());
    try {
      await CrudServices().deleteBarang(event.barangId);
      emit(const CUDBlocSuccess('Barang deleted successfully'));
      add(FetchBarangEvent());
    } catch (e) {
      emit(CUDBlocError('Failed to delete barang: $e'));
    }
  }
}
