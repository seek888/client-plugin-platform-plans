import 'package:flutter_test/flutter_test.dart';

import 'package:demo_app/main.dart';

void main() {
  testWidgets('renders plugin platform demo home', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('插件平台演示'), findsOneWidget);
    expect(find.text('跨端插件平台演示'), findsOneWidget);
    expect(find.text('📅 工作日历插件'), findsOneWidget);
  });
}
