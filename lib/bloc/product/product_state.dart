part of 'product_bloc.dart';

sealed class ProductState {}

final class ProductStateInitial extends ProductState {}

final class ProductStateLoading extends ProductState {}

final class ProductStateComplete extends ProductState {}

final class ProductStateError extends ProductState {
  ProductStateError(this.message);

  final String message;
}
