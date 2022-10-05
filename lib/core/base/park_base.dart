import 'package:customer/core/model/park_history_model.dart';

abstract class ParkBase {
  Future<List<ParkHistory>?> getParkHistories();
}
