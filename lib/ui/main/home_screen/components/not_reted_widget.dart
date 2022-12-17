import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/main/history_screen/components/item_card.dart';
import 'package:customer/ui/main/history_screen/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotRatedWidget extends StatelessWidget {
  const NotRatedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);

    return authView.authProcess == AuthProcess.idle
        ? (authView.notRatedParkHistory.isNotEmpty
            ? Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Rate Now",
                          style: TextStyle(fontSize: 22, color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HistoryScreen(),
                              ),
                            );
                          },
                          child: const Text("See All"),
                        ),
                      ],
                    ),
                    ItemCard(
                      parkHistory: authView.notRatedParkHistory[0],
                    ),
                  ],
                ),
              )
            : Container())
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
