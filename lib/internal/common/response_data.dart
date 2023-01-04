import 'package:flutter/cupertino.dart';

abstract class ResponseData {
  static ValueGetter fromJson = () => null;
  toJson();
}
