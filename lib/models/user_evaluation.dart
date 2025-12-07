import 'package:sahifaty/models/ayat.dart';

import 'evaluation.dart';

class UserEvaluation {
  int? _id;
  int? ayahId;
  List<int>? ayahIds;
  int? evaluationId;
  String? comment;
  Evaluation? evaluation;
  Ayat? ayah;

  UserEvaluation(
      {int? id,
      this.ayahId,
      this.ayahIds,
      this.evaluationId,
      this.comment,
      this.evaluation,
      this.ayah})
      : _id = id;

  int? get id => _id;

  factory UserEvaluation.fromJson(Map<String, dynamic> json) {
    return UserEvaluation(
      id: json['_id'],
      comment: json['comment'] ?? '',
      ayah: json['ayah'] != null ? Ayat.fromJson(json['ayah']) : null,
      evaluation: json['evaluation'] != null
          ? Evaluation.fromJson(json['evaluation'])
          : null,
      // Optional: still store IDs for easy lookup
      ayahId: json['ayah'] != null ? json['ayah']['_id'] : null,
      ayahIds: json['ayahIds'] != null ? List<int>.from(json['ayahIds']) : null,
      evaluationId:
          json['evaluation'] != null ? json['evaluation']['_id'] : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ayahId': ayahId,
      'evaluationId': evaluationId,
      'comment': comment,
      'ayahIds': ayahIds,
    };
  }

  @override
  String toString() {
    return 'UserEvaluation(id: $_id, ayahId: $ayahId, evaluationId: $evaluationId, comment: $comment, evaluation: $evaluation, ayah: $ayah)';
  }
}
