import 'package:flutter_test/flutter_test.dart';

import 'package:dummymart/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('App built and triggers a frame', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ProviderScope(child: DummyMartApp()));
    await tester.pumpAndSettle();
  });
}
