class Taskmodel {
  String taskName;
  String taskDescription;
  bool isHighPriority;
  bool isDone;

  Taskmodel({
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    this.isDone = false,
  });

  factory Taskmodel.fromJson(Map<String, dynamic> json) {
    return Taskmodel(
      taskName: json["taskName"],
      taskDescription: json["taskDescription"],
      isHighPriority: json["isHighPriority"],
      isDone: json["isDone"] ?? false
    );
  }

   Map<String, dynamic> toJson() {
    return {
      "taskName": taskName,
      "taskDescription": taskDescription,
      "isHighPriority": isHighPriority,
      "isDone":isDone,
    };
  }
}
