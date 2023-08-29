import 'types_of_content.dart';

///
///
///
extension MapCasting on MapEntry<String, DTArb<dynamic>> {
  ///
  ///
  ///
  MapEntry<String, R> vCast<R>() => MapEntry<String, R>(
        key,
        value as R,
      );
}
