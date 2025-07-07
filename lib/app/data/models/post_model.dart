import 'package:aluga_facil/app/controllers/user_controller.dart';
import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class PostModel {
  HouseModel? house;
  DateTime? postDate;
  String? situation;
  String? id;
  String? userId;
  String? contact;
  String? observations;
  double? valor;

  final userController = Get.find<UserController>();

  PostModel({
    this.house,
    DateTime? postDate,
    String? id,
    String? userId,
    this.situation,
    this.contact,
    this.observations,
    this.valor,
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
      observations: json['observations'] as String,
      valor: (json['valor'] is int)
          ? (json['valor'] as int).toDouble()
          : (json['valor'] as double),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'house': house!.toJson(),
      'postDate': postDate?.toIso8601String(),
      'id': id,
      'userId': userId,
      'situation': situation,
      'contact': contact,
      'observations': observations,
      'valor': valor,
    };
  }
}
