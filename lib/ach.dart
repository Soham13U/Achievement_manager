import 'package:cloud_firestore/cloud_firestore.dart';

class Ach{
  // ignore: non_constant_identifier_names
  String ach_image;
  String category;
  String description;
  Timestamp createdAt;
  Timestamp updatedAt;

  Ach.fromMap(Map<String,dynamic> data){

    ach_image = data['ach_image'];
    category  = data['category'];
    description = data['description'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }

  
}