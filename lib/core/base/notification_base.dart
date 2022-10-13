import 'package:customer/core/model/notification_model.dart';

abstract class NotificationBase {
  Future<List<NotificationModel>?> getNotifications();
  Future deleteNotification(String id);
}
