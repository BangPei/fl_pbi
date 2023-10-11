class Kios {
  String? location;
  String? block;
  String? blockNo;
  int? totalKios;
  double? kiosWide;
  int? periodeRent;
  String? startDate;
  String? endDate;
  double? monthCost;
  double? electricCost;
  String? signHakGuna;
  String? noHakGuna;

  Kios({
    this.location,
    this.block,
    this.blockNo,
    this.totalKios,
    this.kiosWide,
    this.periodeRent,
    this.startDate,
    this.endDate,
    this.monthCost,
    this.electricCost,
    this.signHakGuna,
    this.noHakGuna,
  });

  Kios.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    block = json['block'];
    blockNo = json['blockNo'];
    totalKios = json['totalKios'];
    kiosWide = json['kiosWide'];
    periodeRent = json['periodeRent'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    monthCost = json['monthCost'];
    electricCost = json['electricCost'];
    signHakGuna = json['signHakGuna'];
    noHakGuna = json['noHakGuna'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = location;
    data['block'] = block;
    data['blockNo'] = blockNo;
    data['totalKios'] = totalKios;
    data['kiosWide'] = kiosWide;
    data['periodeRent'] = periodeRent;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['monthCost'] = monthCost;
    data['electricCost'] = electricCost;
    data['signHakGuna'] = signHakGuna;
    data['noHakGuna'] = noHakGuna;
    return data;
  }
}
