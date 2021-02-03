class Task {
  final String description;

  Task(this.description);

  Task.toJson(Map<String, dynamic> json) : description = json['description'];

  Map<String, dynamic> toJson() => {
        'description': description,
      };
}
