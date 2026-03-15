class ChartEvaluationData {
  int evaluationId;
  String nameAr;
  String code;
  int? characterCount;
  int? verseCount;
  num? percentage;

  ChartEvaluationData(
      {required this.evaluationId,
      required this.nameAr,
      required this.code,
      required this.characterCount,
      required this.verseCount,
      required this.percentage});

  factory ChartEvaluationData.fromJson(Map<String, dynamic> json) {
    return ChartEvaluationData(
        evaluationId: json['evaluationId'],
        nameAr: json['nameAr'],
        code: json['code'],
        characterCount: json['characterCount'],
        verseCount: json['verseCount'],
        percentage: json['percentage']);
  }

  Map<String, dynamic> toMap() {
    return {
      'evaluationId': evaluationId,
      'nameAr': nameAr,
      'code': code,
      'characterCount': characterCount,
      'verseCount': verseCount,
      'percentage': percentage
    };
  }

  @override
  String toString() {
    return 'ChartData(id: $evaluationId, nameAr: $nameAr, code: $code, verseCount: $verseCount, characterCount: $characterCount, percentage: $percentage)';
  }
}
