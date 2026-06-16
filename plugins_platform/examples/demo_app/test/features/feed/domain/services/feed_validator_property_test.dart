import 'package:glados/glados.dart';
import 'package:rss_reader/features/feed/data/services/feed_validator_impl.dart';
import 'package:rss_reader/features/feed/domain/services/feed_validator.dart';
import 'package:rss_reader/core/services/rss_parser_service_impl.dart';

/// **Property 2: URL 验证结果正确性**
/// **Validates: Requirements 1.1, 1.2, 1.3**
///
/// WHEN 用户输入 RSS URL THEN THE Feed_Validator SHALL 自动验证 URL 有效性并返回验证结果

// Custom generators for URL testing
extension UrlGenerators on Any {
  /// Generator for valid HTTP URLs
  Generator<String> get validHttpUrl {
    return any.combine2(any.lowercaseLetters, any.positiveIntOrZero, (
      String domain,
      int index,
    ) {
      final safeDomain = domain.isEmpty ? 'example' : domain;
      return 'http://$safeDomain$index.com/feed.xml';
    });
  }

  /// Generator for valid HTTPS URLs
  Generator<String> get validHttpsUrl {
    return any.combine2(any.lowercaseLetters, any.positiveIntOrZero, (
      String domain,
      int index,
    ) {
      final safeDomain = domain.isEmpty ? 'example' : domain;
      return 'https://$safeDomain$index.com/feed.xml';
    });
  }

  /// Generator for URLs with invalid schemes
  Generator<String> get invalidSchemeUrl {
    return any.combine3(
      any.choose(['ftp', 'file', 'mailto', 'javascript', 'data']),
      any.lowercaseLetters,
      any.positiveIntOrZero,
      (String scheme, String domain, int index) {
        final safeDomain = domain.isEmpty ? 'example' : domain;
        return '$scheme://$safeDomain$index.com/feed.xml';
      },
    );
  }

  /// Generator for URLs without scheme
  Generator<String> get urlWithoutScheme {
    return any.combine2(any.lowercaseLetters, any.positiveIntOrZero, (
      String domain,
      int index,
    ) {
      final safeDomain = domain.isEmpty ? 'example' : domain;
      return '$safeDomain$index.com/feed.xml';
    });
  }

  /// Generator for URLs without host
  Generator<String> get urlWithoutHost {
    return any.combine2(
      any.choose(['http://', 'https://']),
      any.lowercaseLetters,
      (String scheme, String path) {
        return '$scheme/path/${path.isEmpty ? 'feed' : path}.xml';
      },
    );
  }

  /// Generator for whitespace-only strings
  Generator<String> get whitespaceOnly {
    return any.combine2(
      any.positiveIntOrZero,
      any.choose([' ', '\t', '\n', '\r']),
      (int count, String char) {
        final actualCount = (count % 10) + 1; // 1-10 characters
        return char * actualCount;
      },
    );
  }

  /// Generator for valid IP-based URLs
  Generator<String> get validIpUrl {
    return any.combine4(
      any.intInRange(1, 255),
      any.intInRange(0, 255),
      any.intInRange(0, 255),
      any.intInRange(1, 255),
      (int a, int b, int c, int d) {
        return 'http://$a.$b.$c.$d/feed.xml';
      },
    );
  }
}

void main() {
  late FeedValidator validator;

  setUp(() {
    // Create validator with real RSS parser service
    final rssParserService = RssParserServiceImpl();
    validator = FeedValidatorImpl(rssParserService: rssParserService);
  });

  group('Property 2: URL Validation Correctness', () {
    // Property 2a: Valid HTTP URLs should pass format validation
    Glados(any.validHttpUrl).test(
      'Property 2a: Valid HTTP URLs pass format validation',
      (String url) {
        final result = validator.validateUrlFormat(url);

        expect(
          result.isValid,
          isTrue,
          reason: 'Valid HTTP URL "$url" should pass format validation',
        );
        expect(result.errorMessage, isNull);
        expect(result.errorType, isNull);
      },
    );

    // Property 2b: Valid HTTPS URLs should pass format validation
    Glados(any.validHttpsUrl).test(
      'Property 2b: Valid HTTPS URLs pass format validation',
      (String url) {
        final result = validator.validateUrlFormat(url);

        expect(
          result.isValid,
          isTrue,
          reason: 'Valid HTTPS URL "$url" should pass format validation',
        );
        expect(result.errorMessage, isNull);
        expect(result.errorType, isNull);
      },
    );

    // Property 2c: URLs with invalid schemes should fail validation
    Glados(any.invalidSchemeUrl).test(
      'Property 2c: URLs with invalid schemes fail validation',
      (String url) {
        final result = validator.validateUrlFormat(url);

        expect(
          result.isValid,
          isFalse,
          reason: 'URL with invalid scheme "$url" should fail validation',
        );
        // The error type can be either unsupportedScheme or invalidFormat
        // depending on how the URL parser handles the scheme
        expect(
          result.errorType,
          anyOf(
            equals(UrlValidationErrorType.unsupportedScheme),
            equals(UrlValidationErrorType.invalidFormat),
          ),
        );
      },
    );

    // Property 2d: URLs without scheme should fail validation
    Glados(any.urlWithoutScheme).test(
      'Property 2d: URLs without scheme fail validation',
      (String url) {
        final result = validator.validateUrlFormat(url);

        expect(
          result.isValid,
          isFalse,
          reason: 'URL without scheme "$url" should fail validation',
        );
        expect(
          result.errorType,
          anyOf(
            equals(UrlValidationErrorType.invalidFormat),
            equals(UrlValidationErrorType.unsupportedScheme),
          ),
        );
      },
    );

    // Property 2e: Empty URLs should fail validation
    test('Property 2e: Empty URL fails validation', () {
      final result = validator.validateUrlFormat('');

      expect(result.isValid, isFalse);
      expect(result.errorType, equals(UrlValidationErrorType.emptyUrl));
    });

    // Property 2f: Whitespace-only URLs should fail validation
    Glados(any.whitespaceOnly).test(
      'Property 2f: Whitespace-only URLs fail validation',
      (String url) {
        final result = validator.validateUrlFormat(url);

        expect(
          result.isValid,
          isFalse,
          reason: 'Whitespace-only URL should fail validation',
        );
      },
    );

    // Property 2g: Valid IP-based URLs should pass format validation
    Glados(any.validIpUrl).test(
      'Property 2g: Valid IP-based URLs pass format validation',
      (String url) {
        final result = validator.validateUrlFormat(url);

        expect(
          result.isValid,
          isTrue,
          reason: 'Valid IP-based URL "$url" should pass format validation',
        );
      },
    );
  });

  group('URL Validation Edge Cases', () {
    test('URL with port number passes validation', () {
      final result = validator.validateUrlFormat(
        'https://example.com:8080/feed.xml',
      );
      expect(result.isValid, isTrue);
    });

    test('URL with query parameters passes validation', () {
      final result = validator.validateUrlFormat(
        'https://example.com/feed.xml?format=rss',
      );
      expect(result.isValid, isTrue);
    });

    test('URL with fragment passes validation', () {
      final result = validator.validateUrlFormat(
        'https://example.com/feed.xml#section',
      );
      expect(result.isValid, isTrue);
    });

    test('URL with authentication passes validation', () {
      final result = validator.validateUrlFormat(
        'https://user:pass@example.com/feed.xml',
      );
      expect(result.isValid, isTrue);
    });

    test('Localhost URL passes validation', () {
      final result = validator.validateUrlFormat('http://localhost/feed.xml');
      expect(result.isValid, isTrue);
    });

    test('Localhost with port passes validation', () {
      final result = validator.validateUrlFormat(
        'http://localhost:3000/feed.xml',
      );
      expect(result.isValid, isTrue);
    });

    test('URL with subdomain passes validation', () {
      final result = validator.validateUrlFormat(
        'https://blog.example.com/feed.xml',
      );
      expect(result.isValid, isTrue);
    });

    test('URL with multiple subdomains passes validation', () {
      final result = validator.validateUrlFormat(
        'https://a.b.c.example.com/feed.xml',
      );
      expect(result.isValid, isTrue);
    });
  });
}
