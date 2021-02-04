class Task {
  final String description;

  Task({this.description});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      description: json != null ? json['description'] : null,
    );
  }

  Map<String, String> toJson() => {
        'description': description,
      };
}
