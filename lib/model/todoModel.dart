class todoModel {
  int? id;
  String? desc;
  String? due_date;
  bool? is_done;
  int? user_id;

  todoModel({
    this.id,
    this.desc,
    this.is_done = false,
    this.due_date,
    this.user_id,
  });

  factory todoModel.fromJSON(Map<String, dynamic> json) {
    return todoModel(
      id: json['id'],
      desc: json['desc'],
      due_date: json['due_date'],
      is_done: json['is_done'] == 1 ? true : false,
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'desc': desc,
      'due_date': due_date,
      'is_done': is_done == false ? 0 : 1,
      'user_id': user_id,
    };
  }
}
