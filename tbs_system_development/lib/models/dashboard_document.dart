class DashboardDocument {
  final int totalCount;
  final int todayCount;
  final String documentName;

  DashboardDocument(
      {required this.totalCount,
      required this.todayCount,
      required this.documentName});

  factory DashboardDocument.fromJson(Map<String, dynamic> json) =>
      DashboardDocument(
        totalCount: json["totalCount"],
        todayCount: json["todayCount"],
        documentName: json["documentName"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "todayCount": todayCount,
        "documentName": documentName,
      };
}
