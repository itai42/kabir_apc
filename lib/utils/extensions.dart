import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sem_form_core/sem_form_core.dart';

import 'utils.dart';
extension StringOpExtension on String{

  String replaceTokens(Map<String, dynamic> variables) {
    var tmp = this;
    for(var e in variables.entries) {
      tmp = tmp.replaceAll('\$${e.key}', e.value.toString());
    }
    return tmp;
  }

  bool get isNumStr => Regexps.numberString.stringMatch(this)?.length == length;
  bool get isIntStr => Regexps.integerString.stringMatch(this)?.length == length;
}
extension IterableUtilExtension<E> on Iterable<E> {
  ///Returns elements which gives the highest result for func(e)
  Iterable<E> allWhereMax<T extends Comparable>(T? Function(E e) func) sync* {
    T? maxT;
    if (isEmpty) {
      return;
    }
    for (E e in this) {
      final currentT = func(e);
      if (maxT == null || (currentT?.compareTo(maxT).gt(0) ?? false)) {
        maxT = currentT;
      }
    }
    for (E e in this) {
      if (func(e) == maxT) {
        yield e;
      }
    }
  }
  ///Returns elements which gives the lowest result for func(e)
  Iterable<E> allWhereMin<T extends Comparable>(T? Function(E e) func) sync* {
    T? minT;
    if (isEmpty) {
      return;
    }
    for (E e in this) {
      final currentT = func(e);
      if (minT == null || (currentT?.compareTo(minT).lt(0) ?? false)) {
        minT = currentT;
      }
    }
    for (E e in this) {
      if (func(e) == minT) {
        yield e;
      }
    }
  }
}

extension TDExtension on TextDirection{
  TextDirection get reverse => this == TextDirection.ltr?TextDirection.rtl:TextDirection.ltr;
}

extension MapExtension<K, V> on Map<K, V>{
  Map<K, V> filterOut(List<K> filteredKeys) => Map.fromEntries(entries.where((entry) => !filteredKeys.contains(entry.key)));
  Map<K, V> filterIn(List<K> filteredKeys) => Map.fromEntries(entries.where((entry) => filteredKeys.contains(entry.key)));
}

extension IterableUtil<E> on Iterable<E> {
  
  Iterable<T> aggregateYield<T>(T Function(E e, T t) func, T initialT) sync*{
    T currentT = initialT;
    for (E e in this) {
      yield currentT = func(e, currentT);
    }
  }
}
extension ListExtension<E> on List<E> {
  static final Random _random = Random.secure();
  E randomItem() {
    return this[_random.nextInt(length)];
  }
  E? weightedRandomItem(double Function (E element) itemWeightCalculation) {
    final weights = map((e) => itemWeightCalculation(e)).toListNG();
    final total = weights.sum((e) => e)??0;
    if (total <= 0) {
      return null;
    }
    double agg = _random.nextDouble()*total;
    // print ('total: $total, agg: $agg');
    for (int i = 0; i < weights.length; i++) {
      agg -= weights[i];
      if (agg <= 0) {
        return this[i];
      }
    }
    return last;
  }

}
extension IterableExtension<E> on Iterable<E>{
  Iterable<E> filterOut(Iterable<int> filteredIndices) sync* {
    int i = 0;
    final indices = filteredIndices.toSet();
    for (var elem in this) {
      if (!indices.contains(i)) {
        yield elem;
      }
    }
  }
  Iterable<E> filterIn(Iterable<int> filteredIndices) sync* {
    int i = 0;
    final indices = filteredIndices.toSet();
    for (var elem in this) {
      if (indices.contains(i)) {
        yield elem;
      }
    }
  }
}
extension DateWeekExtensions on DateTime {
  DateTime get midDay => DateTime(year, month, day, 12, 0, 0, 0, 0);

  /// The ISO 8601 week of year [1..53].
  ///
  /// Algorithm from https://en.wikipedia.org/wiki/ISO_week_date#Algorithms
  int get weekOfYear {
    // Add 3 to always compare with January 4th, which is always in week 1
    // Add 7 to index weeks starting with 1 instead of 0
    final woy = ((ordinalDate - weekday + 10) ~/ 7);

    // If the week number equals zero, it means that the given date belongs to the preceding (week-based) year.
    if (woy == 0) {
      // The 28th of December is always in the last week of the year
      return DateTime(year - 1, 12, 28).weekOfYear;
    }

    // If the week number equals 53, one must check that the date is not actually in week 1 of the following year
    if (woy == 53 && DateTime(year, 1, 1).weekday != DateTime.thursday && DateTime(year, 12, 31).weekday != DateTime.thursday) {
      return 1;
    }

    return woy;
  }

  /// The ordinal date, the number of days since December 31st the previous year.
  ///
  /// January 1st has the ordinal date 1
  ///
  /// December 31st has the ordinal date 365, or 366 in leap years
  int get ordinalDate {
    const offsets = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    return offsets[month - 1] + day + (isLeapYear && month > 2 ? 1 : 0);
  }

  /// True if this date is on a leap year.
  bool get isLeapYear {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }

  DateTime get monthStart => DateTime(year, month, 1);

  DateTime get monthEnd => DateTime(year, month, daysInMonth, 23, 59, 59, 999, 999);

  ///uses Sunday as first day of week
  DateTime get firstDayOfWeek => weekday == 7 ? this : addDays(-weekday);

  ///uses Sunday as first day of week
  DateTime get lastDayOfWeek => weekday == 6 ? this : addDays(weekday == 7 ? 6 : 6 - weekday);

  DateTime addMonths(int months) {
    final monthSum = (month + months);
    final newMonth = monthSum % 12;
    final addedYears = monthSum ~/ 12;
    return isUtc
        ? DateTime.utc(year + addedYears, newMonth, day, hour, minute, second, millisecond, microsecond)
        : DateTime(year + addedYears, newMonth, day, hour, minute, second, millisecond, microsecond);
  }

  DateTime addDays(int days) {
    return isUtc
        ? DateTime.utc(year, month, day + days, hour, minute, second, millisecond, microsecond)
        : DateTime(year, month, day + days, hour, minute, second, millisecond, microsecond);
  }

  // add(Duration(days: days));

  int get dayOfYear => ordinalDate; //daysSince(firstDayOfYear).floor();

  int get weeksInYear {
    final dec28 = DateTime(year, 12, 28);
    return ((dec28.dayOfYear - dec28.weekday + 10) / 7).floor();
  }
//
// int get weekNumber {
//   final weekNum = ((dayOfYear - weekday + 10) / 7).floor();
//   if (weekNum < 1) {
//     return addMonths(-12).weeksInYear;
//   }
//   if (weekNum > weeksInYear) {
//     return 1;
//   }
//   return weekNum;
// }
}
