class DiscussionFormData {
  final String id;
  final String discussor;
  final String prospector;
  final String contact;
  final String date;
  final String code;

  DiscussionFormData({
    required this.id,
    required this.discussor,
    required this.prospector,
    required this.contact,
    required this.date,
    this.code = ''
  });

  factory DiscussionFormData.fromJson(Map<String, dynamic> json) => DiscussionFormData(
    id: json["id"],
    discussor: json["discusser"],
    prospector: json["prospector"],
    contact: json["mobile_number"],
    date: json["create_date"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "discussor": discussor,
    "prospector": prospector,
    "contact": contact,
    "date": date,
  };
}
