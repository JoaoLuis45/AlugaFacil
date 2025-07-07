import 'package:aluga_facil/app/controllers/user_controller.dart';
import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class PostModel {
  final HouseModel house;
  DateTime? postDate;
  final String situation;
  String? id;
  String? userId;
  final String contact;
  final String obs;
  final double value;

  final userController = Get.find<UserController>();

  PostModel({
    required this.house,
    DateTime? postDate,
    String? id,
    String? userId,
    required this.situation,
    required this.contact,
    required this.obs,
    required this.value,
  })  : postDate = postDate ?? DateTime.now(),
        id = id ?? const Uuid().v4() {
    this.userId = userId ?? userController.loggedUser.id;
  }

  static PostModel fromJson(Map<Object?, Object?> json) {
    return PostModel(
      house: HouseModel.fromJson(json['house'] as Map<String, dynamic>),
      postDate: (json['postDate'] is Timestamp)
          ? (json['postDate'] as Timestamp).toDate()
          : (json['postDate'] is String)
              ? DateTime.tryParse(json['postDate'] as String) ?? DateTime.now()
              : DateTime.now(),
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      situation: json['situation'] as String,
      contact: json['contact'] as String,
      obs: json['obs'] as String,
      value: (json['value'] is int)
          ? (json['value'] as int).toDouble()
          : (json['value'] as double),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'house': house.toJson(),
      'postDate': postDate?.toIso8601String(),
      'id': id,
      'userId': userId,
      'situation': situation,
      'contact': contact,
      'obs': obs,
      'value': value,
    };
  }
}
