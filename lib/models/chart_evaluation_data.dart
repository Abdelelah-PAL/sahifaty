class ChartEvaluationData {
  int evaluationId;
  String nameAr;
  String code;
  int? count;
  num? percentage;

  ChartEvaluationData(
      {required this.evaluationId,
      required this.nameAr,
      required this.code,
      required this.count,
      required this.percentage});

  factory ChartEvaluationData.fromJson(Map<String, dynamic> json) {
    return ChartEvaluationData(
        evaluationId: json['evaluationId'],
        nameAr: json['nameAr'],
        code: json['code'],
        count: json['count'],
        percentage: json['percentage']);
  }

  Map<String, dynamic> toMap() {
    return {
      'evaluationId': evaluationId,
      'nameAr': nameAr,
      'code': code,
      'count': count,
      'percentage': percentage
    };
  }

  @override
  String toString() {
    return 'ChartData(id: $evaluationId, nameAr: $nameAr, code: $code, count: $count, percentage: $percentage)';
  }
}
