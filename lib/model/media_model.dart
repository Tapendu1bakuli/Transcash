/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Service/global_service.dart';
import 'model.dart';

class Media extends Model {
  String? indexId;
  String? name;
  String? url;
  String? thumb;
  String? icon;
  String? size;

  Media({String? id, String? url, String? thumb, String? icon}) {
    this.indexId = id ?? UniqueKey().toString();
    this.url =
        url ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";
    this.thumb =
        thumb ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";
    this.icon =
        icon ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";
  }

  Media.fromJson(Map<String, dynamic> jsonMap) {
    try {
      indexId = jsonMap['id'].toString();
      name = jsonMap['name'];
      url = jsonMap['url'];
      thumb = jsonMap['thumb'];
      icon = jsonMap['icon'];
      size = jsonMap['formatted_size'];
    } catch (e) {
      url = "${Get.find<GlobalService>().baseUrl}images/image_default.png";
      thumb = "${Get.find<GlobalService>().baseUrl}images/image_default.png";
      icon = "${Get.find<GlobalService>().baseUrl}images/image_default.png";
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = indexId;
    map["name"] = name;
    map["url"] = url;
    map["thumb"] = thumb;
    map["icon"] = icon;
    map["formatted_size"] = size;
    return map;
  }

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      super == other &&
          other is Media &&
          runtimeType == other.runtimeType &&
          indexId == other.indexId &&
          name == other.name &&
          url == other.url &&
          thumb == other.thumb &&
          icon == other.icon &&
          size == other.size;

  @override
  int get hashCode =>
      super.hashCode ^
      indexId.hashCode ^
      name.hashCode ^
      url.hashCode ^
      thumb.hashCode ^
      icon.hashCode ^
      size.hashCode;
}
