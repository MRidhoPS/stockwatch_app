part of 'barang_bloc_bloc.dart';

sealed class BarangBlocState extends Equatable {
  const BarangBlocState();
  
  @override
  List<Object> get props => [];
}

final class BarangBlocInitial extends BarangBlocState {}

class BarangBlocLoading extends BarangBlocState{}

class BarangBlocLoaded extends BarangBlocState{
  final List<Barang> barang;

  const BarangBlocLoaded({required this.barang});

  @override
  List<Object> get props => [barang];
}

class BarangBlocError extends BarangBlocState {
  final String message;

  const BarangBlocError(this.message);

  @override
  List<Object> get props => [message];
}

class CUDBlocLoading extends BarangBlocState{}

class CUDBlocSuccess extends BarangBlocState {
  final String message;

  const CUDBlocSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class CUDBlocError extends BarangBlocState {
  final String error;

  const CUDBlocError(this.error);

  @override
  List<Object> get props => [error];
}
