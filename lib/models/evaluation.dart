class Evaluation {
  int? _id;
  String nameAr;
  String code;

  Evaluation({
    int? id,
    required this.nameAr,
    required this.code,
  }) : _id = id;

  int? get id => _id;

  factory Evaluation.fromJson(Map<String, dynamic> json) {
    return Evaluation(
      id: json['_id'],
      nameAr: json['nameAr'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      'nameAr': nameAr,
      'code': code,
    };
  }

  @override
  String toString() {
    return 'Evaluation(id: $_id, nameAr: $nameAr, code: $code)';
  }
}
