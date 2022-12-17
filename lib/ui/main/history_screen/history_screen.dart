import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/main/history_screen/components/item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Park History"),
      ),
      body: authView.authProcess == AuthProcess.idle
          ? (authView.parkHistory.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: authView.parkHistory.length,
                  itemBuilder: (BuildContext context, int i) {
                    return ItemCard(parkHistory: authView.parkHistory[i]);
                  })
              : const Center(child: Text("You dont have park history.")))
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
