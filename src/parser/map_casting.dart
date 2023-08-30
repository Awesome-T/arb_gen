import 'types_of_content.dart';

///
///
///
extension MapCast on MapEntry<String, DTArb<dynamic>> {
  ///
  ///
  ///
  MapEntry<String, R> vCast<R>() => MapEntry<String, R>(
        key,
        value as R,
      );
}
