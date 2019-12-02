import 'dart:async';

Iterable<int> syncNaturalTo(n) sync* {
  print("naturalTo($n) sync* begin");
  for (int i = 0; i < n; i++) {
    print('yield $i start');
    yield i;
    print('yield $i end');
  }
  print("naturalTo($n) sync* end");
}

Stream<int> asyncNaturalTo(n) async* {
  print("asyncNaturalTo($n) async* begin");
  for (int i = 0; i < n; i++) {
    print('yield $i start');
    yield i;
    print('yield $i end');
  }
  print("asyncNaturalTo($n) async* end");
}

int level = 0;
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    print("Begin");
    level = level + 1;
    print('当前 n 为：$n  level 执行次数：$level');
    yield n;
    for (int i in naturalsDownFrom(n - 1)) {
      print('当前 i 为：$i  level 执行次数：$level');
      yield i;
    }
    print("End");
  }
}

Stream<int> stream1() async* {
  await Future.delayed(Duration(seconds: 11));
  yield 1;

  await Future.delayed(Duration(seconds: 11));

  yield 2;

  await Future.delayed(Duration(seconds: 11));

  yield * stream2();


}


Stream<int> stream2() async* {
  await Future.delayed(Duration(seconds: 11));
  yield 3;

  await Future.delayed(Duration(seconds: 11));

  yield 4;
}

main(List<String> args) {
  // Iterator<int> it = syncNaturalTo(4).iterator;
  // while (it.moveNext()) {
  //   print(it.current);
  // }

  // Stream<int> st = asyncNaturalTo(4);
  // // ignore: cancel_subscriptions
  // StreamSubscription<int> sub = st.listen(null);

  // sub.onData((data) {
  //   print('onData $data');
  // });

  // sub.onDone(() {
  //   print('onDone');
  // });

  // Iterator<int> it =  naturalsDownFrom(3).iterator;
  //   while (it.moveNext()) {
  //   print(it.current);
  // }
  Stream<int> st = stream1();
  st.listen((data){
    print(data);
  });

}
