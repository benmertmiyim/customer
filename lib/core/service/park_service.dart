import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/base/park_base.dart';
import 'package:customer/core/model/park_history_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ParkService implements ParkBase {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<List<ParkHistory>?> getParkHistories() async {
    try{
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection("customers/${firebaseAuth.currentUser!.uid}/park_history").get();
      //QuerySnapshot querySnapshot = await firebaseFirestore
      //    .collection("customers/jphPT4kJ0MBJBLzajNI0/park_history").get();
      List<ParkHistory> list = [];
      for (int i = 0; i < querySnapshot.size; i++) {
        Map<String,dynamic> history = querySnapshot.docs[i].data() as Map<String, dynamic>;
        list.add(ParkHistory.fromMap(history));
      }
      return list;
    }catch(e){
      return null;
    }
  }
}
