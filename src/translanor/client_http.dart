import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';

///
///
/// The `IHttpClient` interface defines methods for making HTTP requests.
abstract interface class IHttpClient {
  const IHttpClient();

  /// Performs a ```get``` request and returns the response as a string.
  ///
  /// Takes a `Uri` for the URL and an optional map of headers.
  Future<String> makeGet(Uri url, Map<String, String>? headers);

  /// Performs a ```post``` request and returns the response as a string.
  ///
  /// Takes a `Uri` for the URL, an object for the request body,
  /// and an optional map of headers.
  Future<String> makePost(Uri url, Object? body, Map<String, String>? headers);
}

/// The `ClientHttp` class is an implementation of the `IHttpClient`
/// interface for making HTTP requests.
class ClientHttp implements IHttpClient {
  /// Constructor for `ClientHttp`.
  const ClientHttp();

  @override

  /// Performs a ```get``` request and returns the response as a string.
  ///
  /// Takes a `Uri` for the URL and an optional map of headers.
  Future<String> makeGet(
    Uri url,
    Map<String, String>? headers,
  ) async {
    final httpClient = io.HttpClient();
    final request = await httpClient.getUrl(url);
    if (headers != null) {
      for (final e in headers.entries) {
        request.headers.add(e.key, e.value);
      }
    }
    try {
      await request.flush();
      final response = await request.close();
      if (response.statusCode != HttpStatus.ok) {
        throw HttpException(
          'Error ${response.statusCode}:${await response.length}\n$url',
        );
      }
      final responseBody = await response.transform(utf8.decoder).join();
      return responseBody;
    } catch (e) {
      stdout.write('message $e');
      throw Exception('Error $e');
    } finally {
      httpClient.close();
    }
  }

  @override

  /// Performs a ```post``` request and returns the response as a string.
  ///
  /// Takes a `Uri` for the URL, an object for the request body, and an
  /// optional map of headers.
  Future<String> makePost(
    Uri url,
    Object? body,
    Map<String, String>? headers,
  ) async {
    final httpClient = io.HttpClient();
    try {
      final request = await httpClient.postUrl(url);
      if (headers != null) {
        for (final e in headers.entries) {
          request.headers.add(e.key, e.value);
        }
      }
      request.write(body);
      await request.flush();
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == HttpStatus.ok) return responseBody;
      final msg = 'Error: ${response.statusCode} ${response.reasonPhrase}';
      stdout.write(msg);
      throw HttpException(msg);
    } on io.SocketException catch (e) {
      throw io.SocketException('$e');
    } finally {
      httpClient.close();
    }
  }
}
