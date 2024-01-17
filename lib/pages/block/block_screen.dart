import 'package:fl_pbi/library/app_theme.dart';
import 'package:fl_pbi/pages/block/bloc/block_bloc.dart';
import 'package:fl_pbi/pages/block/data/block.dart';
import 'package:fl_pbi/widget.dart/card_banner.dart';
import 'package:fl_pbi/widget.dart/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class BlockScreen extends StatefulWidget {
  const BlockScreen({super.key});

  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  @override
  void initState() {
    context.read<BlockBloc>().add(OnGetBlocks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppbar(
        title: "List Blok Kios & Lahan",
        actions: IconButton(
          visualDensity: const VisualDensity(vertical: -4),
          onPressed: () => context.goNamed('block-form'),
          icon: const FaIcon(FontAwesomeIcons.plus),
        ),
      ),
      body: BlocBuilder<BlockBloc, BlockState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.isError) {
            return Center(child: Text(state.errorMessage ?? "Error"));
          } else {
            return ListView.builder(
              itemCount: (state.blocks ?? []).length,
              itemBuilder: (ctx, i) {
                Block block = state.blocks![i];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CardBanner(
                    title: "Blok ${block.name}",
                    trailing: const FaIcon(
                      Icons.arrow_right,
                      color: AppTheme.white,
                      size: 40,
                    ),
                    onTap: () {
                      context.goNamed('block-form-crud',
                          pathParameters: {"id": block.id.toString()});
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
