import 'evaluation.dart';

class UserEvaluation {
  int? _id;
  int? ayahId;
  int? evaluationId;
  String? comment;
  Evaluation? evaluation;

  UserEvaluation({
    int? id,
    this.ayahId,
    this.evaluationId,
    this.comment,
    this.evaluation,
  }) : _id = id;

  int? get id => _id;

  factory UserEvaluation.fromJson(Map<String, dynamic> json) {
    return UserEvaluation(
      id: json['_id'],
      ayahId: json['ayahId'],
      evaluationId: json['evaluationId'],
      comment: json['comment'],
      evaluation: json['evaluation'] == null
          ? null
          : Evaluation.fromJson(json['evaluation']),
    );
  }

  Map<String, dynamic> toMap() {
    return {'ayahId': ayahId, 'evaluationId': evaluationId, 'comment': comment};
  }

  @override
  String toString() {
    return 'UserEvaluation(id: $_id, ayahId: $ayahId, evaluationId: $evaluationId, comment: $comment)';
  }
}
