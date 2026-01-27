class DisciplineModel {
  int? id;
  String? name;
  List<int>? referenceCourses;
  int? workload;
  int? semester;
  bool? mandatory;

  DisciplineModel({
    this.id,
    this.mandatory,
    this.name,
    this.referenceCourses,
    this.semester,
    this.workload,
  });

  DisciplineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    referenceCourses = List<int>.from(json['reference_course'] ?? []);
    workload = json['workload_hours'];
    semester = json['semester'];
    mandatory = json['mandatory'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'reference_course': referenceCourses,
      'workload_hours': workload,
      'semester': semester,
      'mandatory': mandatory,
    };
  }
}
