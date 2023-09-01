import 'dart:io';

void out(dynamic ard) {
  // dev.;
  stdout.write('''${'-' * 50}
[log] ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}:${DateTime.now().microsecond}:  $ard''');
//\n ${StackTrace.current}

}
