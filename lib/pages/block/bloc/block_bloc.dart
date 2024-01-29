import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/pages/block/data/block.dart';
import 'package:fl_pbi/pages/block/data/block_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'block_event.dart';
part 'block_state.dart';

class BlockBloc extends Bloc<BlockEvent, BlockState> {
  BlockBloc() : super(const BlockState()) {
    on<OnGetBlocks>(_onGetBlocks);
  }

  void _onGetBlocks(OnGetBlocks event, Emitter<BlockState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, isError: false));
      List<Block> blocks = await BlockApi.getBlocks();
      emit(state.copyWith(isLoading: false, blocks: blocks, isError: false));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          isLoading: false,
          blocks: state.blocks,
          isError: true,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          blocks: state.blocks,
          isError: true,
          errorMessage: e.toString(),
        ));
      }
    }
  }
}
