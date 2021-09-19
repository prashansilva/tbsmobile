class DashboardMemberData {
  final String id;
  final String first_name;
  final String last_name;
  final String mobile_number;
  final String location;
  final String code;
  final String manager_id;
  final String line_leader_id;
  final String role_code;
  final int totalCount;
  final int todayCount;
  final int coordinatorsCount;

  DashboardMemberData({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.mobile_number,
    required this.location,
    required this.code,
    required this.manager_id,
    required this.line_leader_id,
    required this.role_code,
    required this.totalCount,
    required this.todayCount,
    required this.coordinatorsCount,
  });

  factory DashboardMemberData.fromJson(Map<String, dynamic> json) => DashboardMemberData(
    id: json['details']["id"],
    first_name: json['details']["first_name"],
    last_name: json['details']["last_name"]?? '',
    mobile_number: json['details']["mobile_number"]?? '',
    location: json['details']["location"]?? '',
    code: json['details']["code"],
    manager_id: json['details']["manager_id"]?? '',
    line_leader_id: json['details']["line_leader_id"]?? '',
    role_code: json['details']["role_code"],
    totalCount: json["totalCount"],
    todayCount: json["todayCount"],
    coordinatorsCount: json["coordinatorsCount"]?? 0,
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
    "totalCount": totalCount,
    "todayCount": todayCount,
  };
}
