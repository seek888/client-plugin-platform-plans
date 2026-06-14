import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stac_renderer/stac_renderer.dart';

void main() {
  testWidgets('renders text with numeric font weight strings', (tester) async {
    const schema = STACSchema(
      schemaVersion: currentStacSchemaVersion,
      type: 'page',
      children: [
        STACNode(
          type: STACComponentTypes.text,
          props: {'text': 'Strong text'},
          style: STACStyle(fontSize: 16, fontWeight: '700'),
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: STACRenderer.render(schema),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Strong text'), findsOneWidget);
  });
}
