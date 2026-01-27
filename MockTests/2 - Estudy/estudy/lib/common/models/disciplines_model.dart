class DisciplineModel {
  int? id;
  String? name;
  List<int>? referenceCourses;
  int? workload;
  int? semester;
  bool? mandatory;

  DisciplineModel({this.id, this.mandatory, this.name, this.referenceCourses});

  DisciplineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    referenceCourses = json['reference_courses'];
    workload = json['workload'];
    semester = json['semester'];
    mandatory = json['mandatory'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'reference_courses': referenceCourses,
      'workload': workload,
      'semester': semester,
      'mandatory': mandatory,
    };
  }
}
