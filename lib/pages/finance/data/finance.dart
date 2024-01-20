class Finance {
  int? totalPark;
  int? totalIpl;
  int? rest;

  Finance({this.totalPark, this.totalIpl, this.rest});

  Finance.fromJson(Map<String, dynamic> json) {
    totalPark = json['totalPark'];
    totalIpl = json['totalIpl'];
    rest = json['rest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalPark'] = totalPark;
    data['totalIpl'] = totalIpl;
    data['rest'] = rest;
    return data;
  }
}
