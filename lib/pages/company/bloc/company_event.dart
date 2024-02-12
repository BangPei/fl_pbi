part of 'company_bloc.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();
}

class OnInit extends CompanyEvent {
  const OnInit();
  @override
  List<Object> get props => [];
}

class OnChangedName extends CompanyEvent {
  final String val;
  const OnChangedName(this.val);
  @override
  List<Object> get props => [];
}

class OnChangedCategory extends CompanyEvent {
  final Category val;
  const OnChangedCategory(this.val);
  @override
  List<Object> get props => [];
}

class OnAddBlock extends CompanyEvent {
  final BlockDetail val;
  const OnAddBlock(this.val);
  @override
  List<Object> get props => [];
}

class OnRemoveBlock extends CompanyEvent {
  final BlockDetail val;
  const OnRemoveBlock(this.val);
  @override
  List<Object> get props => [];
}
