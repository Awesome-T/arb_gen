import '../util/errors.dart';
import 'i_parser.dart';
import 'types_of_content.dart';

const String _R_STRING = r'{\s*(\w+)\s*((?:[^{}]+|\{(?:[^{}]+|\{[^{}]*\})*\})*)}';

/// Base class `SimpleStrParser`
///
base class SimpleStrParser extends IParset<StringArb> {
  // Default pattern for RegExp
  SimpleStrParser([String pattern = _R_STRING]) : super(RegExp(pattern));

  @override
  Map<String, StringArb>? fromArb(MapEntry<String, dynamic> map) {
    try {
      // Extract placeholders using regex
      final regxPlaceholders = RegExp(r'\{([^{}]+)\}').allMatches(map.value as String);
      final placeholders = <String>[];
      for (final  str in regxPlaceholders) {
        str.group(1) != null ? placeholders.add(str.group(1)!) : null;
      }

      // Return a map with the key and corresponding StringArb
      return <String, StringArb>{
        map.key: StringArb(
          map.value as String,
          regxPlaceholders.isNotEmpty ? placeholders : null,
        ),
      };
    } on IcuParsingException catch (e) {
      throw IcuParsingException('$e');
    }
  }

  @override
  Map<String, dynamic> toArb(
    StringArb parsedChunk,
    List<String> translatedChunk,
    String key,
  ) {
    try {
      // Extract translated string
      final translatedStr = translatedChunk.getRange(0, 1).first;

      // Extract placeholders or use an empty list if null
      final placeholders = parsedChunk.placeholders ?? <String>[];

      // Remove the translated string from the list
      translatedChunk.length == 1 ? translatedChunk.removeLast() : translatedChunk.removeRange(0, 1);

      // Handle placeholders
      if (placeholders.isNotEmpty) {
        // Counter to track the current position in the placeholder array
        var index = 0;

        // Callback function for each match inside {}
        String replaceCallback(Match match) {
          // Ensure that currentIndex does not go beyond the placeholders array
          // Return the current value from the placeholders array and increment index
          if (index < placeholders.length) return '${{placeholders[index++]}}';

          // If index goes beyond the placeholders, return the original value
          return match.group(0)!;
        }

        // Apply the function to each match inside {}
        final val = translatedStr.replaceAllMapped(
          RegExp('{[^}]+}'),
          replaceCallback,
        );

        // Return a map with the key and the replaced value
        return <String, dynamic>{
          key: val,
        };
      }
      // If no placeholders, return a map with the key and the translated string
      else {
        return <String, dynamic>{
          key: translatedStr,
        };
      }
    } on FormatException catch (e, tr) {
      throw FormatException('Error: $e\nTrace: $tr');
    }
  }

  // Return the source value followed by the separator
  // return '${entry.value.source}$separator';
  @override
  String toSingleStr(MapEntry<String, StringArb> entry) => entry.value.source;
}

// ///
// /// Base class `SimpleStrParser`
// ///
// base class SimpleStrParser extends IParset<StringArb> {
//   SimpleStrParser([
//     String patern = _R_STRING,
//   ]) : super(RegExp(patern));
//   @override
//   Map<String, StringArb>? fromArb(MapEntry<String, dynamic> map) {
//     try {
//       // * `_placeholders`
//       final regxPlaceholders = RegExp(r'\{([^{}]+)\}').allMatches(map.value as String);
//       final placeholders = <String>[];
//       for (final str in regxPlaceholders) {
//         str.group(1) != null ? placeholders.add(str.group(1)!) : null;
//       }
//       return <String, StringArb>{
//         map.key: StringArb(
//           map.value as String,
//           regxPlaceholders.isNotEmpty ? placeholders : null,
//         ),
//       };
//     } on IcuParsingException catch (e) {
//       throw IcuParsingException('$e');
//     }
//   }

//   @override
//   Map<String, dynamic> toArb(
//     StringArb parsedChank,
//     List<String> translatedChank,
//     String key,
//   ) {
//     try {
//       // *
//       final translatedStr = translatedChank.getRange(0, 1).first;
//       // *
//       final placeholders = parsedChank.placeholders ?? <String>[];
//       // *
//       translatedChank.length == 1 ? translatedChank.removeLast() : translatedChank.removeRange(0, 1);
//       //*
//       if (placeholders.isNotEmpty) {
//         // Счетчик для отслеживания текущей позиции в массиве placeholder
//         var indx = 0;
//         // Функция, которая будет вызвана для каждого совпадения в скобках {}
//         String replaceCallback(Match match) {
//           // Убеждаемся, что currentIndex не выходит за пределы ```replacementList```
//           // Возвращаем текущее значение из replacementList и увеличиваем indx
//           if (indx < placeholders.length) return '${{placeholders[indx++]}}';
//           // Если indx вышел за пределы _placeholders, возвращаем исходное значение
//           return match.group(0)!;
//         }

//         // * Применяем функцию к каждому совпадению в скобках {}
//         final val = translatedStr.replaceAllMapped(RegExp('{[^}]+}'), replaceCallback);
//         //
//         return <String, dynamic>{
//           key: val,
//         };
//       }
//       // *
//       else {
//         return <String, dynamic>{
//           key: translatedStr,
//         };
//       }
//     } on FormatException catch (e, tr) {
//       throw FormatException('erro $e\ntrace $tr');
//     }
//   }

//   @override
//   String toSingleStr(MapEntry<String, StringArb> entry) {
//     return '${entry.value.source}$separator';
//   }
// }
