import 'package:flutter/material.dart';

import 'bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Bloc _bloc = Bloc();
  bool check_a = false;
  bool check_b = false;
  bool check_c = false;
  int a = 0;
  int b = 0;
  int c = 0;
  bool giaiPT = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Giải Phương trình bậc 2: a.x^2+b.x=c=0!'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    _bloc.checkA(value);
                    try {
                      a = int.parse(value.toString());
                      check_a = true;
                    } catch (e) {
                      check_a = false;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.black)),
                      hintText: 'Nhập số a'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<bool>(
                      stream: _bloc.streamA,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          return snapshot.data == true
                              ? const Text(
                                  'Số a thỏa mãn',
                                  // style: TextStyle(color: Colors.red),
                                )
                              : const Text(
                                  'Số a không thỏa mãn',
                                  style: TextStyle(color: Colors.red),
                                );
                        } else {
                          return Container();
                        }
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: (value) {
                    _bloc.checkB(value);
                    try {
                      b = int.parse(value.toString());
                      check_b = true;
                    } catch (e) {
                      check_b = false;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.black)),
                      hintText: 'Nhập số b'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<bool>(
                      stream: _bloc.streamB,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data == true
                              ? const Text(
                                  'Số b thỏa mãn',
                                  //   style: TextStyle(color: Colors.red),
                                )
                              : const Text(
                                  'Số b không thỏa mãn',
                                  style: TextStyle(color: Colors.red),
                                );
                        } else {
                          return Container();
                        }
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: (value) {
                    _bloc.checkC(value);
                    _bloc.checkD(check_a, check_b, check_c);
                    try {
                      c = int.parse(value.toString());
                      check_c = true;
                    } catch (e) {
                      check_c = false;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.black)),
                      hintText: 'Nhập số c'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<bool>(
                      stream: _bloc.streamC,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data == true
                              ? const Text(
                                  'Số c thỏa mãn',
                                  //  style: TextStyle(color: Colors.red),
                                )
                              : const Text(
                                  'Số c không thỏa mãn',
                                  style: TextStyle(color: Colors.red),
                                );
                        } else {
                          return Container();
                        }
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: StreamBuilder<bool>(
                      stream: _bloc.streamD,
                      builder: (context, snapshot) {
                        _bloc.checkD(check_a, check_b, check_c);
                        return ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  snapshot.data == true
                                      ? Colors.yellow
                                      : Colors.grey)),
                          onPressed: () {
                            if (check_a && check_b && check_c) {
                              // print('ok');
                              _bloc.testPT(a, b, c);
                            }
                          },
                          child: StreamBuilder<bool>(
                              stream: _bloc.streamD,
                              builder: (context, snapshot) {
                                return Text(
                                  'Giải phương trình',
                                  style: TextStyle(
                                      color: snapshot.data == true
                                          ? Colors.black
                                          : Colors.white),
                                );
                              }),
                        );
                      }),
                ),
                StreamBuilder<int>(
                    stream: _bloc.checkPT,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data == 0)
                          return Text('Phương trình vô nghiệm');
                        else if (snapshot.data == 1) {
                          return StreamBuilder<double>(
                              stream: _bloc.tinhA,
                              initialData: _bloc.getX1X2(a, b, c),
                              builder: (context, snapshot) {
                                return Text(
                                    'Phương trình có nghiệm kép x1=x2= ${snapshot.data}');
                              });
                        } else if (snapshot.data == 2) {
                          return Column(
                            children: [
                              Text('Phương trình có 2 nghiệm phân biệt'),
                              StreamBuilder<double>(
                                  stream: _bloc.tinhA,
                                  initialData: _bloc.getX1(a, b, c),
                                  builder: (context, snapshot) {
                                    return Text('x1= ${snapshot.data}');
                                  }),
                              StreamBuilder<double>(
                                  stream: _bloc.tinhB,
                                  initialData: _bloc.getX2(a, b, c),
                                  builder: (context, snapshot) {
                                    return Text('x2= ${snapshot.data}');
                                  })
                            ],
                          );
                        } else
                          return Container();
                      }
                      return Container();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
