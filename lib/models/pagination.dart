import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  const Pagination({
    this.totalCount,
    this.count,
    this.offset,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalCount: json['total_count'] as int?,
        count: json['count'] as int?,
        offset: json['offset'] as int?,
      );
  final int? totalCount;
  final int? count;
  final int? offset;

  Map<String, dynamic> toJson() => {
        'total_count': totalCount,
        'count': count,
        'offset': offset,
      };

  @override
  List<Object?> get props => [totalCount, count, offset];
}
