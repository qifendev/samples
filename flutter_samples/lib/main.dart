import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TestWidget(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Timer? _timer;
  int a = 0;

  test() {
    _timer = Timer(Duration(seconds: 2), () {
      a++;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // child: TestWidget(
        //   counter: _counter,
        // ),
        child: InkWell(
          child: Text('home page'),
          onTap: () {
            test();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TestWidget extends StatefulWidget {
  const TestWidget({super.key, this.counter});

  final int? counter;

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  void initState() {
    super.initState();
    print('TestWidget initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('TestWidget didChangeDependencies');
  }

  @override
  void didUpdateWidget(covariant TestWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('TestWidget didUpdateWidget');
  }

  @override
  Widget build(BuildContext context) {
    print('TestWidget build');
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text('${widget.counter}'),
            InkWell(
              child: Text('button'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyHomePage(title: 'title');
                }));

                // showDialog(
                //     context: context,
                //     builder: (context) {
                //       return Dialog(
                //         child: Text('data'),
                //       );
                //     });
              },
            )
          ],
        ));
  }

  @override
  void deactivate() {
    super.deactivate();
    print('TestWidget deactivate');
  }

  @override
  void reassemble() {
    super.reassemble();
    print('TestWidget reassemble');
  }

  @override
  void dispose() {
    super.dispose();
    print('TestWidget dispose');
  }
}

mixin MixinTest<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
  }
}
