
class Meta {
  final int? status;
  final String? msg;
  final String? responseId;

  Meta({
    this.status,
    this.msg,
    this.responseId,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    status: json["status"],
    msg: json["msg"],
    responseId: json["response_id"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "response_id": responseId,
  };
}