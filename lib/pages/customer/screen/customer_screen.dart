import 'package:fl_pbi/pages/customer/bloc/customer_bloc.dart';
import 'package:fl_pbi/pages/profile/data/profile.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  Map<String, dynamic> map = {};
  @override
  void initState() {
    map = {};
    context.read<CustomerBloc>().add(OnGetCustomer(map));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppbar(
        title: "Customer",
        actions: IconButton(
          visualDensity: const VisualDensity(vertical: -4),
          onPressed: () {},
          icon: const FaIcon(FontAwesomeIcons.plus),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: BlocBuilder<CustomerBloc, CustomerState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.isError) {
              return Center(child: Text(state.errorMessage ?? "Error"));
            } else {
              return SingleChildScrollView(
                child: ListView.separated(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: (state.customers ?? []).length,
                  itemBuilder: (context, i) {
                    Profile customer = state.customers![i];
                    return Text(customer.fullName ?? "--");
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
