import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/models/number.dart';
import 'package:fl_pbi/pages/block/data/block.dart';
import 'package:fl_pbi/pages/block/data/block_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'block_form_event.dart';
part 'block_form_state.dart';

class BlockFormBloc extends Bloc<BlockFormEvent, BlockFormState> {
  BlockFormBloc() : super(const BlockFormState()) {
    on<OnGetBlock>(_onGetBlock);
    on<OnChangedName>(_onChangedName);
    on<OnResetForm>(_onResetForm);
    on<OnAddNumber>(_onAddNumber);
    on<OnSubmit>(_onSubmit);
  }

  void _onSubmit(OnSubmit event, Emitter<BlockFormState> emit) async {
    Block block = state.block ?? Block();
    Map<String, dynamic> map = {
      "id": block.id,
      "name": block.name,
      "numbers": []
    };
    for (var e in (block.numbers ?? [])) {
      Map<String, dynamic> query = {
        "number": {
          "id": e.id,
          "name": e.name,
        },
        "width": e.data['width'],
        "length": e.data['length'],
        "price": e.data['price'],
        "picture": e.data['picture'],
      };
      map['numbers'].add(query);
    }
    if (block.id != null) {
      //put
    } else {
      //post
    }
  }

  void _onAddNumber(OnAddNumber event, Emitter<BlockFormState> emit) {
    Block block = state.block ?? Block();
    Number number = event.number;
    bool isExist = (block.numbers ?? []).any((e) => e.id == number.id);
    if (isExist) {
      for (var e in (block.numbers ?? [])) {
        if (e.id == number.id) {
          e = number;
        }
      }
    } else {
      (block.numbers ?? []).add(number);
    }
    emit(state.copyWith(block: block));
  }

  void _onResetForm(OnResetForm event, Emitter<BlockFormState> emit) {
    Block block = Block();
    emit(state.copyWith(block: block));
  }

  void _onChangedName(OnChangedName event, Emitter<BlockFormState> emit) {
    Block block = state.block ?? Block();
    block.name = event.val;
    emit(state.copyWith(block: block));
  }

  void _onGetBlock(OnGetBlock event, Emitter<BlockFormState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      Block block = await BlockApi.getBlock(event.id.toString());
      emit(state.copyWith(isLoading: false, block: block));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          isLoading: false,
          block: state.block,
          isError: true,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          block: state.block,
          isError: true,
          errorMessage: e.toString(),
        ));
      }
    }
  }
}
