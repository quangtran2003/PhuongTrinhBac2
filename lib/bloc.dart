import 'dart:async';
import 'dart:math';

class Bloc {
  final StreamController<bool> _streamControllerA =
      StreamController.broadcast();
  Stream<bool> get streamA => _streamControllerA.stream;

  final StreamController<bool> _streamControllerB =
      StreamController.broadcast();
  Stream<bool> get streamB => _streamControllerB.stream;

  final StreamController<bool> _streamControllerC =
      StreamController.broadcast();
  Stream<bool> get streamC => _streamControllerC.stream;

  final StreamController<bool> _streamControllerD =
      StreamController.broadcast();
  Stream<bool> get streamD => _streamControllerD.stream;

  StreamController<double> _tinhA = StreamController.broadcast();
  Stream<double> get tinhA => _tinhA.stream;

  StreamController<double> _tinhB = StreamController.broadcast();
  Stream<double> get tinhB => _tinhB.stream;

  StreamController<int> _checkPT = StreamController.broadcast();
  Stream<int> get checkPT => _checkPT.stream;
  int giaiPT = -1;
  void checkA(String a) {
    int number;
    try {
      number = int.parse(a);
      // ignore: unrelated_type_equality_checks
      if (number == 0) {
        _streamControllerA.sink.add(false);
      } else {
        _streamControllerA.sink.add(true);
      }
    } catch (e) {
      _streamControllerA.sink.add(false);
    }
  }

  void checkB(String a) {
    try {
      int.parse(a);
      _streamControllerB.sink.add(true);
    } catch (e) {
      _streamControllerB.sink.add(false);
    }
  }

  void checkC(String a) {
    try {
      int.parse(a);
      _streamControllerC.sink.add(true);
    } catch (e) {
      _streamControllerC.sink.add(false);
    }
  }

  void checkD(bool a, bool b, bool c) {
    if (a == true && b == true && c == true) {
      _streamControllerD.sink.add(true);
    } else {
      _streamControllerD.sink.add(false);
    }
  }

  void testPT(int a, int b, int c) {
    if (b * b - 4 * a * c == 0) {
      _checkPT.sink.add(1);
      _tinhA.sink.add((-b / (2 * a)));
    } else {
      if (b * b - 4 * a * c < 0) {
        _checkPT.sink.add(0);
      } else {
        _checkPT.sink.add(2);

        ;
        _tinhA.sink.add(((-b - sqrt(b * b - 4 * a * c)) / (2 * a)));
        _tinhA.sink.add(((-b + sqrt(b * b - 4 * a * c)) / (2 * a)));
      }
    }
  }

  double getX1X2(int a, int b, int c) {
    return -b / (2 * a);
  }

  double getX1(int a, int b, int c) {
    return ((-b - sqrt(b * b - 4 * a * c)) / (2 * a));
  }

  double getX2(int a, int b, int c) {
    return ((-b + sqrt(b * b - 4 * a * c)) / (2 * a));
  }

  void dispose() {
    _streamControllerA.close();
    _streamControllerB.close();
    _streamControllerC.close();
    _streamControllerD.close();
    _checkPT.close();
  }
}
