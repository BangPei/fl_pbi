part of 'serah_terima_kunci_bloc.dart';

class SerahTerimaKunciState extends Equatable {
  final HakGuna? hakGuna;
  final BlockDetail? blockDetail;
  final bool? isLoading;
  final List<BlockDetail>? blockDetails;
  const SerahTerimaKunciState({
    this.hakGuna,
    this.isLoading,
    this.blockDetails,
    this.blockDetail,
  });

  SerahTerimaKunciState copyWith({
    HakGuna? hakGuna,
    bool? isLoading,
    List<BlockDetail>? blockDetails,
    BlockDetail? blockDetail,
  }) {
    return SerahTerimaKunciState(
      hakGuna: hakGuna ?? this.hakGuna,
      isLoading: isLoading ?? this.isLoading,
      blockDetails: blockDetails ?? this.blockDetails,
      blockDetail: blockDetail ?? this.blockDetail,
    );
  }

  @override
  List<Object?> get props => [hakGuna, isLoading, blockDetails, blockDetail];
}
