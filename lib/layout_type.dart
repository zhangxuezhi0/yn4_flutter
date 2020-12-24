import 'package:flutter/foundation.dart';

abstract class HasLayoutGroup {
  VoidCallback get onLayoutToggle;
}

enum LayoutEnums {
  list,
  about,
}

String layoutName(LayoutEnums layoutType) {
  switch (layoutType) {
    case LayoutEnums.list:
      return 'list';
    case LayoutEnums.about:
      return 'developing';
    default:
      return 'default';
  }
}
