class DocumentData {
  final String id;
  final String email;
  final String first_name;
  final String gender;
  final String create_date_time;
  final String update_date_time;

  DocumentData({
    required this.id,
    required this.first_name,
    required this.email,
    required this.gender,
    required this.create_date_time,
    required this.update_date_time,
  });

  factory DocumentData.fromJson(Map<String, dynamic> json) => DocumentData(
    id: json["id"],
    email: json["email"],
    first_name: json["first_name"],
    gender: json["gender"],
    create_date_time: json["create_date_time"],
    update_date_time: json["update_date_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": first_name,
    "gender": gender,
    "create_date_time": create_date_time,
    "update_date_time": update_date_time,
  };
}
