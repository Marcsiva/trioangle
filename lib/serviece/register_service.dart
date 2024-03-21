
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/register_model.dart';

class RegisterController{
  CollectionReference registerCollection = FirebaseFirestore.instance.collection('Register');

  Future<void > createRegister(RegisterModel model) async{
    await registerCollection.doc(model.phone).set(model.toJson());
  }

  Future<List<RegisterModel>> fetchData(String phone) async {
    try {
      QuerySnapshot<Object?> snapshot =
      await registerCollection.where("phone",isEqualTo: phone).get();
      List<RegisterModel> data = snapshot.docs
          .map((doc) => RegisterModel.fromDoc(doc))
          .toList();
      return data;
    } catch (e) {
      print('Error fetching data: $e');
      return []; // Return empty list in case of error
    }
  }

  Future<void> update(String phone,String uid)async{
    try{
      if(phone.isNotEmpty){
        await registerCollection.doc(phone).update({'uid':uid});
      }else{
        throw Exception("Invalid register No");
      }
    }
    catch (e){
      print(e);
    }
  }}