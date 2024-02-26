import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/category_model.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class CategoryRepository {
  CollectionReference<CategoryModel> categoryRef =
      FirebaseService.db.collection("categories").withConverter<CategoryModel>(
            fromFirestore: (snapshot, _) {
              return CategoryModel.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );
  Future<List<QueryDocumentSnapshot<CategoryModel>>> getCategories() async {
    try {
      var data = await categoryRef.get();
      bool hasData = data.docs.isNotEmpty;
      if (!hasData) {
        makeCategory().forEach((element) async {
          await categoryRef.add(element);
        });
      }
      final response = await categoryRef.get();
      var category = response.docs;
      return category;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<DocumentSnapshot<CategoryModel>> getCategory(String categoryId) async {
    try {
      print(categoryId);
      final response = await categoryRef.doc(categoryId).get();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  List<CategoryModel> makeCategory() {
    return [
      CategoryModel(
          categoryName: "ROLEX",
          status: "active",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/en/thumb/9/95/Rolex_logo.svg/1200px-Rolex_logo.svg.png"),
      CategoryModel(
          categoryName: "Armani",
          status: "active",
          imageUrl:
              "https://logowik.com/content/uploads/images/armani8432.jpg"),
      CategoryModel(
          categoryName: "Daniel Wellington",
          status: "active",
          imageUrl:
              "https://logonoid.com/images/daniel-wellington-logo.jpg"),
      CategoryModel(
          categoryName: "Curren",
          status: "active",
          imageUrl:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTjUrN9Plt6VC5-64TsczIOBtKk_8RoaQ2SQ7lKWha2VsRquv1DJhG14i_hbn6urNLm7s&usqp=CAU"),
      CategoryModel(
          categoryName: "Tissot",
          status: "active",
          imageUrl:
              "https://i.pinimg.com/736x/0f/58/7d/0f587d9f22b372c311a58805ef14a5a0.jpg"),
    ];
  }
}
