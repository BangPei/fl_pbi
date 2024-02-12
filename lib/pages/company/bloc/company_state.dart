part of 'company_bloc.dart';

final class CompanyState extends Equatable {
  final List<Category>? categories;
  final List<BlockDetail>? blockDetails;
  final Company? company;
  final bool? isLoading;
  final bool? isError;
  final String? errorMessage;

  const CompanyState({
    this.categories,
    this.isLoading,
    this.errorMessage,
    this.isError,
    this.company,
    this.blockDetails,
  });

  CompanyState copyWith({
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    Company? company,
    List<Category>? categories,
    List<BlockDetail>? blockDetails,
  }) {
    return CompanyState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      company: company ?? this.company,
      blockDetails: blockDetails ?? this.blockDetails,
    );
  }

  @override
  List<Object?> get props => [
        company,
        categories,
        isLoading,
        isError,
        errorMessage,
        blockDetails,
      ];
}
