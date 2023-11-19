
class Pagination {
  final int? totalCount;
  final int? count;
  final int? offset;

  Pagination({
    this.totalCount,
    this.count,
    this.offset,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalCount: json["total_count"],
    count: json["count"],
    offset: json["offset"],
  );

  Map<String, dynamic> toJson() => {
    "total_count": totalCount,
    "count": count,
    "offset": offset,
  };
}