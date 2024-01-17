part of 'block_bloc.dart';

abstract class BlockEvent extends Equatable {
  const BlockEvent();
}

class OnGetBlocks extends BlockEvent {
  @override
  List<Object?> get props => [];
}
