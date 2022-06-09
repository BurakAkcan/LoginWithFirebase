import 'package:json_annotation/json_annotation.dart';
part 'student_model.g.dart';

@JsonSerializable()
class Student {
  final String name;
  final int number;

  Student(this.name, this.number);

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
