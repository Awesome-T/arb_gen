/// Extension for objects of type T with the 'let' method
// extension Let<T> on T {
//   /// The 'let' method takes a function f, applies it to the current object of type T,
//   /// and returns the result of type R
//   R let<R>(R Function(T) f) => f(this);
//   /// The 'also' method takes a function f and applies it to the current object of type T,
//   /// but returns the current object itself, which is convenient for sequential operations
//   T also(void Function(T) f) {
//     f(this);
//     return this;
//   }
//   /// The 'run' method calls the function f, passing the current object of type T to it,
//   /// and returns the result of type R
//   R run<R>(R Function(T) f) => f(this);
//   /// The 'apply' method calls the function f, passing the current object of type T to it,
//   /// and returns the current object, which is convenient for sequential operations
//   T apply(T Function(T) f) => f(this);
//   /// The 'map' method applies the function f to the current object of type T
//   /// and returns a new object with changes
//   R map<R>(R Function(T) f) => f(this);
//   /// The 'takeIf' method returns the current object if the condition is true,
//   /// otherwise returns null
//   T? takeIf(bool Function(T) condition) => condition(this) ? this : null;
//   /// The 'takeUnless' method returns the current object if the condition is false,
//   /// otherwise returns null
//   T? takeUnless(bool Function(T) condition) => condition(this) ? null : this;
// }

///
// extension Exte<T> on Map<dynamic, T> {
//   /// First single value
//   T get fValue => entries.first.value;

//   /// First Key in map
//   dynamic get fKey => entries.first.key;

//   ///
//   MapEntry<dynamic, T> get fEntry => entries.first;
// }
