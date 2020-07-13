import 'dart:async' show Future;
import 'package:mvc_pattern/mvc_pattern.dart' show ControllerMVC;
import 'package:swiftvote/src/app.dart' show App;


class Con extends ControllerMVC {
  factory Con() {
    return _this ??= Con._();
  }
  static Con _this;

  Con._();

  static Con get con => _this;

//  String get title => App.title;

  /// Called by the View.
//  void init() => loadData();
//
//  Future loadData() async{
//    var load = await "LOADED";
//    refresh();
//    return load;
//  }
}