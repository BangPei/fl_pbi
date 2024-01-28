class Finance {
  double? totalPark;
  double? totalIpl;
  double? rest;

  Finance({this.totalPark, this.totalIpl, this.rest});

  Finance.fromJson(Map<String, dynamic> json) {
    totalPark = json['totalPark'].runtimeType == int
        ? json['totalPark'].toDouble()
        : json['totalPark'];
    totalIpl = json['totalIpl'].runtimeType == int
        ? json['totalIpl'].toDouble()
        : json['totalIpl'];
    rest = json['rest'].runtimeType == int
        ? json['rest'].toDouble()
        : json['rest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalPark'] = totalPark;
    data['totalIpl'] = totalIpl;
    data['rest'] = rest;
    return data;
  }
}
