// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Reult {
  int? id;
  String? content;

  Reult();

  factory Reult.fromJson(Map<String, dynamic> json) => _$ReultFromJson(json);
  Map<String, dynamic> toJson() => _$ReultToJson(this);
}
