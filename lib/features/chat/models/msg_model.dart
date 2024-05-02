import 'package:hive/hive.dart';

part 'msg_model.g.dart';

@HiveType(typeId: 1)
class MsgModel {
  MsgModel({
    required this.userId,
    required this.sentBy,
    required this.msg,
    required this.date,
  });

  factory MsgModel.fromMap(Map<String, dynamic> map) {
    return MsgModel(
      userId: map['userId'] as String,
      sentBy: map['sentBy'] as String,
      msg: map['msg'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String sentBy;

  @HiveField(2)
  final String msg;

  @HiveField(3)
  final DateTime date;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'sentBy': sentBy,
      'msg': msg,
      'date': date.millisecondsSinceEpoch,
    };
  }

  @override
  String toString() => 'MsgModel(userId: $userId, sentBy: $sentBy, '
      'msg: $msg, date: $date)';
}
