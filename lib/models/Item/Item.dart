import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Category {
  final int id;

  final String name;
  final String description;
  final String imageUrl;
  final String facebookLink;
  final String youtypeLink;
  final String whatsAppLink;
  final String locationLink;
  final String phoneLink;
  final String location;
  final String number;

  Category({
    required this.id,
    required this.facebookLink,
    required this.youtypeLink,
    required this.whatsAppLink,
    required this.locationLink,
    required this.phoneLink,
    required this.location,
    required this.number,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'number': number,
      'location': location,
      'phoneLink': phoneLink,
      'locationLink': locationLink,
      'whatsAppLink': whatsAppLink,
      'youtypeLink': youtypeLink,
      'facebookLink': facebookLink,
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      number: json['number'],
      location: json['location'],
      phoneLink: json['phoneLink'],
      locationLink: json['locationLink'],
      whatsAppLink: json['whatsAppLink'],
      facebookLink: json['facebookLink'],
      youtypeLink: json['youtypeLink'],
    );
  }
}

