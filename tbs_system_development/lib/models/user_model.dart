class UserData {
  final String id;
  final String first_name;
  final String last_name;
  final String mobile_number;
  final String location;
  final String code;
  final String manager_id;
  final String line_leader_id;
  final String role_code;

  UserData({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.mobile_number,
    required this.location,
    required this.code,
    required this.manager_id,
    required this.line_leader_id,
    required this.role_code,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        first_name: json["first_name"],
        last_name: json["last_name"]?? '',
        mobile_number: json["mobile_number"]?? '',
        location: json["location"]?? '',
        code: json["code"],
        manager_id: json["manager_id"]?? '',
        line_leader_id: json["line_leader_id"]?? '',
        role_code: json["role_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": first_name,
        "last_name": last_name,
        "mobile_number": mobile_number,
        "location": location,
        "code": code,
        "manager_id": manager_id,
        "line_leader_id": line_leader_id,
        "role_code": role_code,
      };
}
