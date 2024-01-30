import 'package:equatable/equatable.dart';

/// [Meta] holds the response statusCode [status], response message [msg] ,
/// response ID [responseId]
class Meta extends Equatable {
  /// [Meta] Constructor
  const Meta({
    this.status,
    this.msg,
    this.responseId,
  });

  /// Meta.toJson() factory constructor.
  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        status: json['status'] as int?,
        msg: json['msg'] as String?,
        responseId: json['response_id'] as String?,
      );

  /// response statusCode
  final int? status;

  /// response message
  final String? msg;

  /// response
  final String? responseId;

  /// convert the [Meta] class to json
  Map<String, dynamic> toJson() => {
        'status': status,
        'msg': msg,
        'response_id': responseId,
      };

  @override
  List<Object?> get props => [status, msg, responseId];
}
