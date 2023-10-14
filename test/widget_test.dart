import 'package:flutter_test/flutter_test.dart';

import 'package:dummymart/main.dart';

void main() {
  testWidgets('App built and triggers a frame', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(DummyMartApp());
  });
}
