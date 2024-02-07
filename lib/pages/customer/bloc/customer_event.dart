part of 'customer_bloc.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();
}

class OnGetCustomer extends CustomerEvent {
  final Map<String, dynamic> map;
  const OnGetCustomer(this.map);
  @override
  List<Object?> get props => [];
}
