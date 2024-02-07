part of 'customer_bloc.dart';

class CustomerState extends Equatable {
  const CustomerState({
    this.isError = false,
    this.isLoading = false,
    this.errorMessage,
    this.customers,
  });

  final bool isLoading;
  final bool isError;
  final String? errorMessage;
  final List<Profile>? customers;

  CustomerState copyWith({
    bool? isError,
    bool? isLoading,
    String? errorMessage,
    List<Profile>? customers,
  }) {
    return CustomerState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      customers: customers ?? this.customers,
    );
  }

  @override
  List<Object?> get props => [isError, errorMessage, isLoading, customers];
}
