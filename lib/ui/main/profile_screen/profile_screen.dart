import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/auth/verify_phone_screen/verify_phone_screen.dart';
import 'package:customer/ui/components/went_wrong_widget.dart';
import 'package:customer/ui/main/history_screen/history_screen.dart';
import 'package:customer/ui/main/other_screen/other_screen.dart';
import 'package:customer/ui/main/payment_methods_screen/payment_methods_screen.dart';
import 'package:customer/ui/main/profile_screen/components/tile_widget.dart';
import 'package:customer/ui/main/wallet_history_screen/wallet_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);

    if (authView.authProcess == AuthProcess.idle) {
      if (authView.customer != null) {
        return ListView(
          children: [
            Column(
              children: [
                TileWidget(title: authView.customer!.nameSurname),
                TileWidget(title: authView.customer!.email),
                TileWidget(title: authView.customer!.phone,isPhone: !authView.customer!.verified,onClick: !authView.customer!.verified ? (){Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VerifyPhoneScreen(),
                  ),
                );}:null,),
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
                  title: "Wallet History",
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WalletHistoryScreen(),
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
                TileWidget(
                  title: "Logout",
                  onClick: () {
                    authView.signOut();
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
