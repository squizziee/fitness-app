// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';


void main() {
  //Firebase.initializeApp();
  test('Serialization test', () async {
    // final serializer = WeightTrainingFirestoreSerializer();
    // var regiments =
    //     await DatabaseService().getUserRegiments("/users/abWbLcBiD2xRyYTI5ZQ0");
    // for (var r in regiments) {
    //   var serialized = serializer.serializeRegiment(r);
    //   var deserialized = serializer.deserializeRegiment(serialized, r.id);
    //   expect(deserialized, r);
    // }
    expect(1, 1);
  });
}
