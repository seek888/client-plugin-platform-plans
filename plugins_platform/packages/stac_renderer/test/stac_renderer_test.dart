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

  testWidgets('dispatches plugin events from buttons', (tester) async {
    String? eventName;
    Map<String, dynamic>? eventParams;

    const schema = STACSchema(
      schemaVersion: currentStacSchemaVersion,
      type: 'page',
      children: [
        STACNode(
          type: STACComponentTypes.button,
          id: 'submit',
          props: {'text': 'Submit'},
          events: {STACEventTypes.onTap: 'handleSubmit'},
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: STACRenderer.render(
          schema,
          eventHandler: (name, params) async {
            eventName = name;
            eventParams = params;
            return STACUpdate.none();
          },
        ),
      ),
    );

    await tester.tap(find.text('Submit'));
    await tester.pump();

    expect(eventName, 'handleSubmit');
    expect(eventParams?['nodeId'], 'submit');
    expect(eventParams?['handler'], 'handleSubmit');
  });

  testWidgets('applies patch updates to the source schema', (tester) async {
    const schema = STACSchema(
      schemaVersion: currentStacSchemaVersion,
      type: 'page',
      children: [
        STACNode(
          type: STACComponentTypes.button,
          props: {'text': 'Change'},
          events: {STACEventTypes.onTap: 'handleChange'},
        ),
        STACNode(
          type: STACComponentTypes.text,
          props: {'text': 'Before'},
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: STACRenderer.render(
          schema,
          eventHandler: (name, params) async {
            return STACUpdate.patch([
              replace('/children/1/props/text', 'After'),
            ]);
          },
        ),
      ),
    );

    expect(find.text('Before'), findsOneWidget);

    await tester.tap(find.text('Change'));
    await tester.pump();

    expect(find.text('Before'), findsNothing);
    expect(find.text('After'), findsOneWidget);
  });
}
