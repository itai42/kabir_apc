import 'package:flutter/material.dart';
import 'package:sem_form_core/sem_form_core.dart';

class ShowSymbol {
  final String symbol;
  final Color? color;

  const ShowSymbol(this.symbol, [this.color = Colors.green]);
}

abstract class UnicodeChars {
  static const int brailleBlank = 0x2800;
  static const int dash = 0x05be;

  /// <i class="material-icons-outlined md-36">pause</i> &#x2014; material icon named "pause" (outlined).
  static const int ellipsis = 0x2026;
  static const int starOfDavid = 0x2721;

  @ShowSymbol('✓', Colors.green)
  static const int vMark = 0x2713;

  @ShowSymbol('🥪', Colors.green)
  static const int sandwich = 0x1F96A;

  @ShowSymbol('🚫', Colors.green)
  static const int noEntry = 0x1F6AB;

  @ShowSymbol('₀', Colors.green)
  static const int subZero = 0x2080;

  @ShowSymbol('₁', Colors.green)
  static const int subOne = 0x2081;

  @ShowSymbol('₂', Colors.green)
  static const int subTwo = 0x2082;

  @ShowSymbol('₃', Colors.green)
  static const int subThree = 0x2083;

  @ShowSymbol('₄', Colors.green)
  static const int subFour = 0x2084;

  @ShowSymbol('₅', Colors.green)
  static const int subFive = 0x2085;

  @ShowSymbol('₆', Colors.green)
  static const int subSix = 0x2086;

  @ShowSymbol('₇', Colors.green)
  static const int subSeven = 0x2087;

  @ShowSymbol('₈', Colors.green)
  static const int subEight = 0x2088;

  @ShowSymbol('₉', Colors.green)
  static const int subNine = 0x2089;

  static Map<String, int> supers = {
    'x': superX,
    'X': superX,
    '0': superZero,
    '1': superOne,
    '2': superTwo,
    '3': superThree,
    '4': superFour,
    '5': superFive,
    '6': superSix,
    '7': superSeven,
    '8': superEight,
    '9': superNine,
    '.': superDot,
    ',': superComma,
  };

  static List<int> superNum(num value, [String Function(num)? formattingFunc]) {
    final str = formattingFunc == null ? value.toString() : formattingFunc(value);
    return str.characters.map((c) => supers[c]).nonNullListNG;
  }
  static List<int> superString(String value) {
    return value.characters.map((c) => supers[c]).nonNullListNG;
  }
  @ShowSymbol('𝄛', Colors.green)
  static const int sixLineStaff = 0x1D11B;

  @ShowSymbol('𐤇', Colors.green)
  static const int phoenicianLetterHet = 0x10907;
  @ShowSymbol('⋅', Colors.green)
  static const int superDot = 0x22C5;

  @ShowSymbol('⋅', Colors.green)
  static const int superComma = 0x02BC;

  @ShowSymbol('⁄', Colors.green)
  static const int superFractionSlash = 0x2044;

  @ShowSymbol('⁻', Colors.green)
  static const int superFractionMinus = 0x207B;

  @ShowSymbol('ˣ', Colors.green)
  static const int superX = 0x02E3;

  @ShowSymbol('⁰', Colors.green)
  static const int superZero = 0x2070;
  @ShowSymbol('¹', Colors.green)
  static const int superOne = 0x00B9;

  @ShowSymbol('²', Colors.green)
  static const int superTwo = 0x00B2;

  @ShowSymbol('³', Colors.green)
  static const int superThree = 0x00B3;

  @ShowSymbol('⁴', Colors.green)
  static const int superFour = 0x2074;

  @ShowSymbol('⁵', Colors.green)
  static const int superFive = 0x2075;

  @ShowSymbol('⁶', Colors.green)
  static const int superSix = 0x2076;

  @ShowSymbol('⁷', Colors.green)
  static const int superSeven = 0x2077;

  @ShowSymbol('⁸', Colors.green)
  static const int superEight = 0x2078;

  @ShowSymbol('⁹', Colors.green)
  static const int superNine = 0x2079;

  @ShowSymbol('✔', Colors.green)
  static const int heavy_vMark = 0x2714;

  @ShowSymbol('✕', Colors.green)
  static const int xMark = 0x2715;

  @ShowSymbol('✖', Colors.green)
  static const int heavy_xMark = 0x2716;

  @ShowSymbol('⚕', Colors.green)
  static const int aesculapius = 0x2695;
}

abstract class KnownStrings {
  static final String brailleBlank = String.fromCharCode(UnicodeChars.brailleBlank);
  static final String dash = String.fromCharCode(UnicodeChars.dash);

  /// <i class="material-icons-outlined md-36">pause</i> &#x2014; material icon named "pause" (outlined).
  static final String ellipsis = String.fromCharCode(UnicodeChars.ellipsis);
  static final String starOfDavid = String.fromCharCode(UnicodeChars.starOfDavid);
  static final String vMark = String.fromCharCode(UnicodeChars.vMark);
  static final String xMark = String.fromCharCode(UnicodeChars.xMark);

  ///⚕
  static final String aesculapius = String.fromCharCode(UnicodeChars.aesculapius);
}

abstract class KnownIcons {
  static const IconData brailleBlank = IconData(UnicodeChars.brailleBlank);
  static const IconData vMark = IconData(UnicodeChars.vMark);
  static const IconData xMark = IconData(UnicodeChars.xMark);
  static const IconData dash = IconData(UnicodeChars.dash);

  /// <i class="material-icons-outlined md-36">pause</i> &#x2014; material icon named "pause" (outlined).
  static const IconData ellipsis = IconData(UnicodeChars.ellipsis);
  static const IconData starOfDavid = IconData(UnicodeChars.starOfDavid);

  ///⚕
  static const IconData aesculapius = IconData(UnicodeChars.aesculapius);

  static const IconData noEntry = IconData(UnicodeChars.noEntry);
  static const IconData sandwich = IconData(UnicodeChars.sandwich);
}
