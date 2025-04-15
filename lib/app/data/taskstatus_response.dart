class TaskStatusResponse {
  bool? success;
  String? message;
  List<Taskstatus>? taskstatus;

  TaskStatusResponse({this.success, this.message, this.taskstatus});

  TaskStatusResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['taskstatus'] != null) {
      taskstatus = <Taskstatus>[];
      json['taskstatus'].forEach((v) {
        taskstatus!.add(new Taskstatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.taskstatus != null) {
      data['taskstatus'] = this.taskstatus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Taskstatus {
  int? id;
  String? name;
  String? color;
  int? isDefault;
  int? order;
  String? createdAt;
  String? updatedAt;

  Taskstatus(
      {this.id,
      this.name,
      this.color,
      this.isDefault,
      this.order,
      this.createdAt,
      this.updatedAt});

  Taskstatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    isDefault = json['is_default'];
    order = json['order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['is_default'] = this.isDefault;
    data['order'] = this.order;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
