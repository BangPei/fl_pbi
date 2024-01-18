part of 'block_form_bloc.dart';

abstract class BlockFormEvent extends Equatable {
  const BlockFormEvent();
}

class OnGetBlock extends BlockFormEvent {
  final int id;
  const OnGetBlock(this.id);
  @override
  List<Object?> get props => [];
}

class OnChangedName extends BlockFormEvent {
  final String val;
  const OnChangedName(this.val);
  @override
  List<Object?> get props => [];
}

class OnResetForm extends BlockFormEvent {
  @override
  List<Object?> get props => [];
}
