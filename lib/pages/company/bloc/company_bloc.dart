import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/pages/company/data/company.dart';
import 'package:fl_pbi/pages/block/data/block_api.dart';
import 'package:fl_pbi/pages/block/data/block_details.dart';
import 'package:fl_pbi/pages/category/data/category.dart';
import 'package:fl_pbi/pages/category/data/category_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc() : super(const CompanyState()) {
    on<OnInit>(_onInit);
    on<OnChangedName>(_onChangedName);
    on<OnChangedCategory>(_onChangedCategory);
    on<OnAddBlock>(_onAddBlock);
    on<OnRemoveBlock>(_onRemoveBlock);
  }

  void _onChangedName(OnChangedName event, Emitter<CompanyState> emit) {
    Company company = state.company ?? Company();
    company.name = event.val;
    emit(state.copyWith(company: company));
  }

  void _onChangedCategory(OnChangedCategory event, Emitter<CompanyState> emit) {
    Company company = state.company ?? Company();
    company.category = event.val;
    emit(state.copyWith(company: company));
  }

  void _onAddBlock(OnAddBlock event, Emitter<CompanyState> emit) {
    Company company = state.company ?? Company();
    company.blockDetails = state.company?.blockDetails ?? [];
    company.blockDetails?.add(event.val);
    emit(state.copyWith(company: company));
  }

  void _onRemoveBlock(OnRemoveBlock event, Emitter<CompanyState> emit) {
    Company company = state.company ?? Company();
    company.blockDetails?.removeWhere((e) => e.id == event.val.id);
    emit(state.copyWith(company: company));
  }

  void _onInit(OnInit event, Emitter<CompanyState> emit) async {
    emit(state.copyWith(isLoading: true, isError: false, company: Company()));
    try {
      List<Category> categories = await CategoryApi.get();
      List<BlockDetail> blockDetails = await BlockApi.getBlockDetails();
      emit(state.copyWith(
        isLoading: false,
        categories: categories,
        isError: false,
        blockDetails: blockDetails,
      ));
    } catch (e) {
      if (e.runtimeType == DioException) {
        DioException err = e as DioException;
        emit(state.copyWith(
          isLoading: false,
          categories: state.categories,
          isError: true,
          blockDetails: state.blockDetails,
          errorMessage: err.response?.data?["message"] ?? err.message,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          categories: state.categories,
          isError: true,
          blockDetails: state.blockDetails,
          errorMessage: e.toString(),
        ));
      }
    }
  }
}
