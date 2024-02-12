part of 'form_customer_bloc.dart';

final class FormCustomerState extends Equatable {
  final bool? isLoading;
  final bool? isError;
  final String? errorMessage;
  final Profile? customer;
  const FormCustomerState({
    this.customer,
    this.errorMessage,
    this.isError,
    this.isLoading,
  });

  FormCustomerState copyWith({
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    Profile? customer,
  }) {
    return FormCustomerState(
      customer: customer ?? this.customer,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [errorMessage, isError, customer, isLoading];
}
