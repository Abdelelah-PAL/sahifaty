class Evaluation {
  String nameAr;
  String code;


  Evaluation({
    required this.nameAr,
    required this.code,
  });


  factory Evaluation.fromJson(Map<String, dynamic> json) {
    return Evaluation(
      nameAr: json['nameAr'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nameAr': nameAr,
      'code': code,
    };
  }
}
