import 'package:tbssystemdevelopment/models/dashboard_document.dart';

class DashboardData {
  final int totalCount;
  final int todayCount;
  final int leadersCount;
  final int coordinatorsCount;
  final int leadersSubCount;
  final int coordinatorsSubCount;
  final int myPersonal;
  final List<DashboardDocument> documents;

  DashboardData({
    required this.totalCount,
    required this.todayCount,
    required this.leadersCount,
    required this.coordinatorsCount,
    required this.leadersSubCount,
    required this.coordinatorsSubCount,
    required this.documents,
    required this.myPersonal,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
    totalCount: json["totalCount"],
    todayCount: json["todayCount"],
    myPersonal: json["myPersonalCount"],
    leadersCount: json["leadersCount"],
    coordinatorsCount: json["coordinatorsCount"],
    leadersSubCount: json["leadersSubmissionCount"],
    coordinatorsSubCount: json["coordinatorsSubmissionCount"],
    documents: parseDocuments(json),
  );

  static List<DashboardDocument> parseDocuments(json) {
    if (json['documents'] == null) {
      return [];
    }
    var list = (json['documents']) as List;
    List<DashboardDocument> documentList =
    list.map((data) => DashboardDocument.fromJson(data)).toList();
    return documentList;
  }
}
