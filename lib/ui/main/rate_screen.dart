import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/model/rate_model.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({Key? key, required this.parkHistory}) : super(key: key);
  final ParkHistory parkHistory;

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  double security = 5;
  double serviceQuality = 5;
  double accessibility = 5;
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.parkHistory.parkName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Security",
                style: TextStyle(fontSize: 24),
              ),
              RatingStars(
                value: security,
                onValueChanged: (v) {
                  //
                  setState(() {
                    security = v;
                  });
                },
                starBuilder: (index, color) => Icon(
                  Icons.star,
                  color: color,
                  size: 32,
                ),
                starCount: 5,
                starSize: 32,
                valueLabelColor: const Color(0xff9b9b9b),
                valueLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16),
                valueLabelRadius: 10,
                maxValue: 5,
                starSpacing: 2,
                maxValueVisibility: true,
                valueLabelVisibility: true,
                animationDuration: const Duration(milliseconds: 500),
                valueLabelPadding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                valueLabelMargin: const EdgeInsets.only(right: 8),
                starOffColor: const Color(0xffe7e8ea),
                starColor: Colors.yellow,
              ),
              const Text(
                "Service Quality",
                style: TextStyle(fontSize: 24),
              ),
              RatingStars(
                value: serviceQuality,
                onValueChanged: (v) {
                  //
                  setState(() {
                    serviceQuality = v;
                  });
                },
                starBuilder: (index, color) => Icon(
                  Icons.star,
                  color: color,
                  size: 32,
                ),
                starCount: 5,
                starSize: 32,
                valueLabelColor: const Color(0xff9b9b9b),
                valueLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16),
                valueLabelRadius: 10,
                maxValue: 5,
                starSpacing: 2,
                maxValueVisibility: true,
                valueLabelVisibility: true,
                animationDuration: const Duration(milliseconds: 500),
                valueLabelPadding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                valueLabelMargin: const EdgeInsets.only(right: 8),
                starOffColor: const Color(0xffe7e8ea),
                starColor: Colors.yellow,
              ),
              const Text(
                "Accessibility",
                style: TextStyle(fontSize: 24),
              ),
              RatingStars(
                value: accessibility,
                onValueChanged: (v) {
                  //
                  setState(() {
                    accessibility = v;
                  });
                },
                starBuilder: (index, color) => Icon(
                  Icons.star,
                  color: color,
                  size: 32,
                ),
                starCount: 5,
                starSize: 32,
                valueLabelColor: const Color(0xff9b9b9b),
                valueLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16),
                valueLabelRadius: 10,
                maxValue: 5,
                starSpacing: 2,
                maxValueVisibility: true,
                valueLabelVisibility: true,
                animationDuration: const Duration(milliseconds: 500),
                valueLabelPadding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                valueLabelMargin: const EdgeInsets.only(right: 8),
                starOffColor: const Color(0xffe7e8ea),
                starColor: Colors.yellow,
              ),
              const Text(
                "Note",
                style: TextStyle(fontSize: 24),
              ),
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                controller: myController,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: null,
              ),
              const SizedBox(
                height: 16,
              ),
              Consumer<AuthView>(
                builder: (BuildContext context, value, Widget? child) {
                  if (value.authProcess == AuthProcess.idle) {
                    return SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () async {
                          RateModel rateModel = RateModel(
                              security: security,
                              serviceQuality: serviceQuality,
                              accessibility: accessibility,
                              customerId: widget.parkHistory.uid,
                              vendorId: widget.parkHistory.vendorId,
                              processId: widget.parkHistory.requestId,
                              commentDate: Timestamp.now(),
                              message: myController.text);
                          await value
                              .ratePark(widget.parkHistory, rateModel)
                              .then(
                            (value) {
                              if (value) {
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Something went wrong !"),
                                  ),
                                );
                              }
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: const Text("Send"),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
