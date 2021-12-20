class ExerciseDetail {
  int? exerciseDetailId;
  int? exerciseId;
  String? description;
  String? detail;
  String? imageDescription;

  ExerciseDetail({this.exerciseDetailId, this.exerciseId, this.description, this.detail, this.imageDescription});

  factory ExerciseDetail.fromJson(Map<String, dynamic> json) => ExerciseDetail(
      exerciseDetailId: json['exerciseDetailId'] as int?,
      exerciseId: json['exercise']['id'] as int?,
      description: json['description'] as String?,
      detail: json['detail'] as String?,
      imageDescription: json['imageDescription'] as String?);
}