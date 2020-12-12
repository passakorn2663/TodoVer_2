import 'dart:core';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:todo2/provider/uuid.dart';

@immutable
@JsonSerializable() // แปลงข้อมูล class todo -> json เพื่อเก็บข้อมูลแบบ textfile
class TodoList {
  final List<TodoModel> todos;
  //ตัวแปรเก็บ List

  TodoList(this.todos);

  factory TodoList.fromJson(Map<String, dynamic> json) =>
      _$TodoListFromJson(json);

  Map<String, dynamic> toJson() => _$TodoListToJson(this);
}

@immutable
@JsonSerializable()
class TodoModel {
  final bool complete;
  final String id;
  final String title;
  final String detail;

  TodoModel({this.complete = false, String id, this.title, this.detail = ''})
      : this.id = id ?? Uuid().generateV4(),
        super();
  //ถูกสร้างด้วย UUid

  TodoModel copyWith({bool complete, String id, String title, String detail}) {
    return TodoModel(
        complete: complete ?? this.complete,
        id: id ?? this.id,
        title: title ?? this.title,
        detail: detail ?? this.detail);
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
  //แปลง class เป็น json

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
  //แปลง json เป็น class
}

TodoList _$TodoListFromJson(Map<String, dynamic> json) {
  return TodoList(
    (json['todos'] as List)
        ?.map((e) =>
            e == null ? null : TodoModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TodoListToJson(TodoList instance) => <String, dynamic>{
      'todos': instance.todos,
    };

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) {
  return TodoModel(
    complete: json['complete'] as bool,
    id: json['id'] as String,
    title: json['title'] as String,
    detail: json['detail'] as String,
  );
}

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) => <String, dynamic>{
      'complete': instance.complete,
      'id': instance.id,
      'title': instance.title,
      'detail': instance.detail,
    };
