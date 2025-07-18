class GSTSectionData {
  final String st;
  final String title;
  final String details;

  GSTSectionData({
    required this.st,
    required this.title,
    required this.details,
  });

  // Factory method to create an instance from JSON
  factory GSTSectionData.fromJson(Map<String, dynamic> json) {
    return GSTSectionData(
      st: json['st'],
      title: json['title'],
      details: json['details'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'st': st,
      'title': title,
      'details': details,
    };
  }
}