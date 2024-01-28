class CashFlow {
  double? inCome;
  double? outCome;
  double? rest;

  CashFlow({this.inCome, this.outCome, this.rest});

  CashFlow.fromJson(Map<String, dynamic> json) {
    inCome = json['inCome'].runtimeType == int
        ? json['inCome'].toDouble()
        : json['inCome'];
    outCome = json['outCome'].runtimeType == int
        ? json['outCome'].toDouble()
        : json['outCome'];
    rest = json['rest'].runtimeType == int
        ? json['rest'].toDouble()
        : json['rest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inCome'] = inCome;
    data['outCome'] = outCome;
    data['rest'] = rest;
    return data;
  }
}
