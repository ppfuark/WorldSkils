class CourseModel {
  int? id;
  String? name;
  String? area;
  String? realeasedDate;
  int? durationSem;
  bool? active;

  CourseModel({
    this.id,
    this.name,
    this.area,
    this.realeasedDate,
    this.durationSem,
    this.active,
  });

  CourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    area = json['area'];
    realeasedDate = json['released_date'];
    durationSem = json['duration_semesters'];
    active = json['active'];
  }
}
