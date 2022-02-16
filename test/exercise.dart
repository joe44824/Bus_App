// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Cubit Testing", () async {
    final cubit = CounterCubit(0);
    final subscription = cubit.stream.listen(print);
    cubit.increment();
    await Future.delayed(Duration.zero);
    await subscription.cancel();
    await cubit.close();
  });

  expect("", "");
}

class CounterCubit extends Cubit<int> {
  CounterCubit(int initialState) : super(initialState);

  void increment() => emit(state + 1);
}
