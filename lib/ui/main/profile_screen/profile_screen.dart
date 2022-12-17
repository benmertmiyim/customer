import 'package:customer/core/view/auth_view.dart';
import 'package:customer/core/view/card_view.dart';
import 'package:customer/core/view/notification_view.dart';
import 'package:customer/ui/auth/verify_phone_screen/verify_phone_screen.dart';
import 'package:customer/ui/components/went_wrong_widget.dart';
import 'package:customer/ui/main/history_screen/history_screen.dart';
import 'package:customer/ui/main/other_screen/other_screen.dart';
import 'package:customer/ui/main/payment_methods_screen/payment_methods_screen.dart';
import 'package:customer/ui/main/profile_screen/components/tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);
    CardView cardView = Provider.of<CardView>(context);
    NotificationView notificationView = Provider.of<NotificationView>(context);

    if (authView.authProcess == AuthProcess.idle) {
      if (authView.customer != null) {
        return ListView(
          children: [
            Column(
              children: [
                TileWidget(
                  subTitle: authView.customer!.nameSurname,
                  title: "Name Surname",
                ),
                TileWidget(
                  subTitle: authView.customer!.email,
                  title: "Email",
                ),
                TileWidget(
                  subTitle: authView.customer!.phone,
                  title: "Phone",
                  isPhone: !authView.customer!.verified,
                  onClick: !authView.customer!.verified
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VerifyPhoneScreen(),
                            ),
                          );
                        }
                      : null,
                ),
                TileWidget(
                  title: 'Park History',
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HistoryScreen(),
                      ),
                    );
                  },
                ),

                TileWidget(
                  title: "Payment Methods",
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentMethodsScreen(),
                      ),
                    );
                  },
                ),
                TileWidget(
                  title: "Other",
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OtherScreen(),
                      ),
                    );
                  },
                ),
                const TileWidget(
                  title: "Support",
                  subTitle: "+850 123 12 12",
                ),
                TileWidget(
                  title: "Logout",
                  onClick: () {
                    Alert(
                      context: context,
                      type: AlertType.warning,
                      title: "Logout",
                      desc: "Are you sure, do you want to logout?",
                      buttons: [
                        DialogButton(
                          color: Colors.red,
                          child: const Text(
                            "Yes",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            authView.signOut();
                            notificationView.logout();
                            cardView.logout();
                          },
                        ),
                        DialogButton(
                          color: Colors.green,
                          child: const Text(
                            "No",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ).show();
                  },
                  isLogout: true,
                ),
              ],
            ),
          ],
        );
      } else {
        return const WentWrongWidget();
      }
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
