import 'package:flutter_test/flutter_test.dart';
import 'package:eritv_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const EritvApp());

    // Verify that the app title is displayed
    expect(find.text('ERi-TV'), findsOneWidget);
  });
}
