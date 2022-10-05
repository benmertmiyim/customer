import 'package:customer/core/base/park_base.dart';
import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/service/park_service.dart';
import 'package:customer/locator.dart';
import 'package:flutter/material.dart';

enum ParkProcess {
  idle,
  busy,
}

class ParkView with ChangeNotifier implements ParkBase {
  ParkProcess _parkProcess = ParkProcess.idle;
  ParkService parkService = locator<ParkService>();
  List<ParkHistory>? parkHistories;


  ParkProcess get parkProcess => _parkProcess;

  set parkProcess(ParkProcess value) {
    _parkProcess = value;
    notifyListeners();
  }

  ParkView() {
    getParkHistories();
  }

  @override
  Future<List<ParkHistory>?> getParkHistories() async {
    try {
      parkProcess = ParkProcess.busy;
      parkHistories = await parkService.getParkHistories();
    } catch (e) {
      debugPrint(
        "ParkView - Exception - Park Histories : ${e.toString()}",
      );
    } finally {
      parkProcess = ParkProcess.idle;
    }
    return parkHistories;
  }
}
