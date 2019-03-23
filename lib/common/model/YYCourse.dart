import 'package:json_annotation/json_annotation.dart';
import 'package:lychee/common/model/YYLesson.dart';

part 'YYCourse.g.dart';

@JsonSerializable()
class YYCourse {
  double id;
  /**
   * 分类id
   */
  int category;
  /**
   * 类型，0 图文，1 语音，2 视频
   */
  int type;
  /**
   * 开设课程的Scholar id
   */
  double sid;
  /**
   * 是否免费，0收费，1免费
   */
  int free;
  String title;
  /**
   * 封面
   */
  String cover;
  /**
   * 标价
   */
  int markedPrice;
  /**
   * 销售价格,0表示免费，-1表示不单独销售
   */
  int salePrice;
  /**
   * 优惠
   */
  int discount;
  /**
   * 课程简介
   */
  String introduction;
  /**
   * 发布人名称
   */
  String author;
  /**
   * 发布人头像
   */
  String avatar;
  /**
   * 发布人荣誉
   */
  String honor;
  List<YYLesson> lessonList;
  bool paid;
  int lessonQuantity;
  bool favorite;
  String uuid;

  YYCourse(
    this.id,
    this.category,
    this.type,
    this.sid,
    this.free,
    this.title,
    this.cover,
    this.markedPrice,
    this.salePrice,
    this.discount,
    this.introduction,
    this.author,
    this.avatar,
    this.honor,
    this.lessonList,
    this.paid,
    this.lessonQuantity,
    this.favorite,
    this.uuid
  );

  factory YYCourse.fromJson(Map<String, dynamic> json) => _$YYCourseFromJson(json);

  Map<String, dynamic> toJson() => _$YYCourseToJson(this);
}
