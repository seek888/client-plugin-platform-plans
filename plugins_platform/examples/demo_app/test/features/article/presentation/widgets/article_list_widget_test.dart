import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rss_reader/features/article/presentation/widgets/article_list.dart';

void main() {
  testWidgets('renders actionable empty article state', (tester) async {
    var refreshCount = 0;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 390,
              height: 640,
              child: ArticleList(
                articles: const [],
                onRefresh: () async {
                  refreshCount += 1;
                },
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('暂无文章'), findsOneWidget);
    expect(find.text('刷新文章'), findsOneWidget);

    await tester.tap(find.text('刷新文章'));
    await tester.pump();

    expect(refreshCount, 1);
  });
}
