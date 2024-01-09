class CashFlow {
  int? inCome;
  int? outCome;
  int? rest;

  CashFlow({this.inCome, this.outCome, this.rest});

  CashFlow.fromJson(Map<String, dynamic> json) {
    inCome = json['inCome'];
    outCome = json['outCome'];
    rest = json['rest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inCome'] = inCome;
    data['outCome'] = outCome;
    data['rest'] = rest;
    return data;
  }
}
