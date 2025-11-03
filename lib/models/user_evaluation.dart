class UserEvaluation {
  int? _id;
  int ayahId;
  int evaluationId;
  String? comment;

  UserEvaluation(
      {int? id, required this.ayahId, required this.evaluationId, this.comment})
      : _id = id;

  int? get id => _id;

  factory UserEvaluation.fromJson(Map<String, dynamic> json) {
    return UserEvaluation(
        id: json['_id'],
        ayahId: json['ayahId'],
        evaluationId: json['evaluationId'],
        comment: json['comment']);
  }

  Map<String, dynamic> toMap() {
    return {'ayahId': ayahId, 'evaluationId': evaluationId, 'comment': comment};
  }

  @override
  String toString() {
    return 'UserEvaluation(id: $_id, ayahId: $ayahId, evaluationId: $evaluationId, comment: $comment)';
  }
}
