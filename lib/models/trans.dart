class Trans {
  int? year;
  String? month;
  int? no;
  int? data;
  double? amount;

  Trans({this.year, this.month, this.no, this.data, this.amount});

  Trans.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    no = json['no'];
    data = json['data'];
    if (json['amount'].runtimeType == int) {
      amount = json['amount'].toDouble();
    } else {
      amount = double.parse(json['amount']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['month'] = month;
    data['no'] = no;
    data['data'] = this.data;
    data['amount'] = amount;
    return data;
  }
}
