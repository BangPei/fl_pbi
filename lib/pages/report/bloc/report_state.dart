part of 'report_bloc.dart';

final class ReportState extends Equatable {
  const ReportState({
    this.report,
    this.isLoading,
    this.isError,
    this.errorMessage,
    this.map,
  });
  final TransactionReport? report;
  final bool? isLoading;
  final bool? isError;
  final String? errorMessage;
  final Map<String, dynamic>? map;

  ReportState copyWith({
    TransactionReport? report,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    Map<String, dynamic>? map,
  }) {
    return ReportState(
      errorMessage: errorMessage ?? this.errorMessage,
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      report: report ?? this.report,
      map: map ?? this.map,
    );
  }

  @override
  List<Object?> get props => [
        report,
        isLoading,
        isError,
        errorMessage,
        map,
      ];
}
