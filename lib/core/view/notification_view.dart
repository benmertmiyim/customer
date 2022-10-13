import 'package:customer/core/base/notification_base.dart';
import 'package:customer/core/model/notification_model.dart';
import 'package:customer/core/service/notification_service.dart';
import 'package:customer/locator.dart';
import 'package:flutter/material.dart';

enum NotificationProcess {
  idle,
  busy,
}

class NotificationView with ChangeNotifier implements NotificationBase {
  NotificationProcess _notificationProcess = NotificationProcess.idle;
  NotificationService notificationService = locator<NotificationService>();
  List<NotificationModel>? notificationList;


  NotificationProcess get notificationProcess => _notificationProcess;

  set notificationProcess(NotificationProcess value) {
    _notificationProcess = value;
    notifyListeners();
  }


  NotificationView(){
    getNotifications();
  }


  @override
  Future<List<NotificationModel>?> getNotifications() async {
    try {
      notificationProcess = NotificationProcess.busy;
      notificationList = await notificationService.getNotifications();
    } catch (e) {
      debugPrint(
        "NotificationView - Exception - Get Notifications : ${e.toString()}",
      );
    } finally {
      notificationProcess = NotificationProcess.idle;
    }
    return notificationList;
  }

  @override
  Future deleteNotification(String id) async {
    try {
      await notificationService.deleteNotification(id);
      notificationList?.removeWhere((model) => model.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint(
        "NotificationView - Exception - Delete Notifications : ${e.toString()}",
      );
    }
  }
}
