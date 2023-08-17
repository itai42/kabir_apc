
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:wardle/data_classes/enums.dart';
// import 'package:wardle/data_classes/month.dart';
// import 'package:wardle/process/process_controller.dart';

class SingleValueChangeNotifier<T> extends ChangeNotifier {
  T _value;

  T get value => _value;

  set value(T value) {
    if (value != _value) {
      _value = value;
      notifyListeners();
    }
  }

  void markDirty() {
    notifyListeners();
  }
  SingleValueChangeNotifier(T value) : _value = value;
}
//
// class SingleValueStateNotifier<T> extends StateNotifier<T> {
//   T _value;
//
//   T get value => _value;
//
//   set value(T value) {
//     if (value != _value) {
//       _value = value;
//     }
//   }
//
//   void markDirty() {
//     // notifyListeners();
//   }
//   SingleValueStateNotifier(T value) : _value = value, super(value);
// }

class PausableChangeNotifier<T> extends ChangeNotifier {
  bool _paused;
  bool pauseValueReads;
  T _value;
  T? _valueBeforePaused;

  T get value => pauseValueReads && _paused ? (_valueBeforePaused??_value) : _value;

  PausableChangeNotifier({required T value, bool startPaused = false, this.pauseValueReads = true})
      : _paused = startPaused,
        _value = value;

  void pause() {
    if (_paused) {
      return;
    }
    _paused = true;
    _valueBeforePaused = value;
  }

  void resume() {
    if (!_paused) {
      return;
    }
    _paused = false;
    if (_valueBeforePaused != value) {
      notifyListeners();
    }
  }

  set value(T newValue) {
    if (_value == newValue) {
      return;
    }
    _value = newValue;
    if (!_paused) {
      notifyListeners();
    }
  }
}
class PausableRefCountingChangeNotifier<T> extends ChangeNotifier {
  bool get _paused => _refCount <= 0;
  bool pauseValueReads;
  T _value;
  T? _valueBeforePaused;
  int _refCount;

  T get value => pauseValueReads && _paused ? (_valueBeforePaused??_value) : _value;

  PausableRefCountingChangeNotifier({required T value, bool startPaused = false, this.pauseValueReads = true})
      : _refCount = startPaused?1:0,
        _value = value;

  void pause() {
    if (!_paused) {
      _valueBeforePaused = value;
    }
    _refCount++;
  }

  void resume() {
    if (!_paused) {
      return;
    }
    _refCount--;
    if (!_paused && _valueBeforePaused != value) {
      notifyListeners();
    }
  }

  set value(T newValue) {
    if (_value == newValue) {
      return;
    }
    _value = newValue;
    if (!_paused) {
      notifyListeners();
    }
  }
}

abstract class Cloneable<T> {
  const Cloneable();
  T clone();
}
extension CloneableListExtension<T extends Cloneable<T>> on List<T>{
  List<T> clone({bool growable = true}) => map((element) => element.clone()).toList(growable: growable);
}

extension CloneableSetExtension<T extends Cloneable<T>> on Set<T>{
  Set<T> clone() => map((element) => element.clone()).toSet();
}

extension CloneableMapExtension<K extends Cloneable<K>, V extends Cloneable<V>> on Map<K, V>{
  Map<K, V> clone() => Map.fromEntries(entries.map((entry) => MapEntry(entry.key.clone(), entry.value.clone())));
}

extension KeyCloneableMapExtension<K extends Cloneable<K>, V> on Map<K, V>{
  Map<K, V> clone() => Map.fromEntries(entries.map((entry) => MapEntry(entry.key.clone(), entry.value)));
}

extension ValueCloneableMapExtension<K, V extends Cloneable<V>> on Map<K, V>{
  Map<K, V> clone() => Map.fromEntries(entries.map((entry) => MapEntry(entry.key, entry.value.clone())));
}
abstract class Regexps {
  static final RegExp numberOrPercentString = RegExp(r'(\b(?:[-]\s*)\d+(?:[\.,]\d+)?\b(?!(?:[\.,]\d+)|(?:\s*(?:%|percent))))');
  static final RegExp numberString = RegExp(r'(\b(?:[-]\s*)\d+(?:[\.,]\d+))');
  static final RegExp integerString = RegExp(r'(\b(?:[-]\s*)\d+(?:[,]\d+))');
}
class InstanceOf<T extends Cloneable> {
  final T original;
  final T instance;
  const InstanceOf.constant({required this.original}) : instance = original;
  InstanceOf({required this.original, T? instance}) : instance = instance ?? original.clone();

  InstanceOf<T> copyWith({T? original, T? instance}) => InstanceOf(original: original??this.original, instance: instance??this.instance);


}

class CloneableInstanceOf<T extends Cloneable> extends InstanceOf<T> implements Cloneable<CloneableInstanceOf<T>>{
  CloneableInstanceOf({required super.original, T? instance}) : super(instance: instance ?? original.clone());

  @override
  CloneableInstanceOf<T> copyWith({T? original, T? instance}) => CloneableInstanceOf(original: original??this.original, instance: instance??this.instance);

  @override
  CloneableInstanceOf<T> clone() => copyWith(original: original, instance: instance.clone());

  // void compile({required ProcessController processController, required MonthInfo month, required RuleScope scope}) {}
  //
  // void compileRules(ProcessController processController, {required bool rebuild}) {}

}

class ValueRange<T> {
  T min;
  T max;
  ValueRange(this.min, this.max);
  @override String toString() => '($min - $max)';
}

class TimedValue<T,V> {
  final T time;
  final V value;
  const TimedValue(this.time, this.value);
}