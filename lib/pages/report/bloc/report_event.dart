part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();
}

class OnChangedPeriode extends ReportEvent {
  final Map<String, dynamic> map;
  const OnChangedPeriode(this.map);
  @override
  List<Object?> get props => [];
}

class OnInitPDFView extends ReportEvent {
  final String reportType;
  const OnInitPDFView(this.reportType);
  @override
  List<Object?> get props => [];
}

class OnInit extends ReportEvent {
  const OnInit();
  @override
  List<Object?> get props => [];
}
