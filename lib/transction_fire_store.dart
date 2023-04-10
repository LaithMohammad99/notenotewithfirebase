
import 'package:cloud_firestore/cloud_firestore.dart';

getAllData() async {
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  await users.orderBy('age', descending: true).limit(2).get().then((value) {
    value.docs.forEach((element) {
      print(element.data());
      print("=======================================");
    });
  });
}

getOneDoc() async {
  DocumentReference docs = FirebaseFirestore.instance
      .collection('users')
      .doc("0Kzc5PRvmU6cbiEPjKvH");
  await docs.get().then((value) {
    print(value.data());
    print("----------------------------------------,,-------------------");
  });
}

//where("lang",here....)
//where in is used for more if
//array contain Check one value
//array containAny more on check
getDataByAge() async {
  var userRef = FirebaseFirestore.instance.collection("users");
  await userRef.get().then((QuerySnapshot<Map<String, dynamic>> value) {
    value.docs.forEach((element) {
      print(element.data()["user_name"]);
    });
  });
}

filterTowCollection() async {
  var reference = FirebaseFirestore.instance.collection('users');
  await reference.get().then((value) => {
    value.docs.forEach((element) {
      print('user name ${element.data()['user_name']}');
      print('======================================================');
      print('age${element.data()['phone']}');
      print('======================================================');
      print('email ${element.data()['email']}');
      print('======================================================');
    })
  });
}

liveConnectionFireBase() async {
  FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
    event.docs.forEach((element) {
      print(element.data()['age']);
    });
  });
}

addDataFromFireStoreToDocs() async{
  var userRef = FirebaseFirestore.instance.collection('users');
  // userRef.add({"user_name":"laith new",
  //              "age":22,
  //              "email":"laithnew@gmail.com",
  //              "phone":0785121484});
  await  userRef.doc('4').set({"name": "ahmad", "age": 2});
}

upDateDataFireStoreIntoDocs() async{
  var userRef = FirebaseFirestore.instance.collection('users');
  await userRef.doc('4').update({});
}

deleteDocs() async{
  var userRef = FirebaseFirestore.instance.collection('users');
  await  userRef
      .doc('4')
      .delete()
      .then((value) => {print('successfully')})
      .catchError((onError) {
    print('Error Not Successfully ${onError}');
  });
}

nestedCollection() async{
  var userRef = FirebaseFirestore.instance
      .collection('users')
      .doc('01qXF4plvw6uAsewALb0')
      .collection('address');

  await  userRef.doc('1FvsFHQAGLvxcZPywWjv').get().then((value) {}).catchError((onError){});
}

trans() async{
  var docRef=FirebaseFirestore.instance.collection('users').doc('01qXF4plvw6uAsewALb0');
  FirebaseFirestore.instance.runTransaction((transaction)async {
    //start trans

    DocumentSnapshot docData=await transaction.get(docRef);
    if(docData.exists){
      transaction.update(docRef, {});
      print('true');
    }


    //end transd
  });

}

var docsOne=FirebaseFirestore.instance.collection('users').doc('01qXF4plvw6uAsewALb0');
var docsTow=FirebaseFirestore.instance.collection('users').doc('rwuUxFog2Pogx6Qw9jNo');


batchWrite()async{
  var batch=FirebaseFirestore.instance.batch();
  batch.delete(docsOne);
  batch.update(docsTow, {});
}
