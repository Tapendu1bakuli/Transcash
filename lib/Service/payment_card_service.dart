import 'package:flutter/material.dart';

import '../common/device_manager/assets.dart';

class PaymentCard {
  CardType? type;
  String? number;
  String? name;
  int? month;
  int? year;
  int? cvv;

  PaymentCard({ this.type,  this.number,  this.name,  this.month,  this.year,  this.cvv});

  @override
  String toString() {
    return '[Type: $type, Number: $number, Name: $name, Month: $month, Year: $year, CVV: $cvv]';
  }
}

enum CardType {
  Master,
  Visa,
  Verve,
  Discover,
  AmericanExpress,
  DinersClub,
  Jcb,
  Others,
  Invalid
}

class CardUtils {
  static String? validateCVV(String value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }

    if (value.length < 3 || value.length > 4) {
      return "CVC is invalid";
    }
    return null;
  }

  static String? validateDate(String value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }

    int year;
    int month;
    // The value contains a forward slash if the month and year has been
    // entered.
    if (value.contains(new RegExp(r'(/)'))) {
      var split = value.split(new RegExp(r'(/)'));
      // The value before the slash is the month while the value to right of
      // it is the year.
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      // Only the month was entered
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }

    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return  'Invalid' /*'Expiry month is invalid'*/;
    }

    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return  'Invalid'/*'Expiry year is invalid'*/;
    }

    if (!hasDateExpired(month, year)) {
      return "Expired";
    }
    return null;
  }

  /// Convert the two-digit year to four-digit year if necessary
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(new RegExp(r'(/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }

  static String getCleanedNumber(String text) {
    RegExp regExp = new RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  static Widget getCardIcon(CardType cardType) {
    debugPrint("Card type: $cardType");
    String img = "";
    Icon icon= new Icon(
      Icons.credit_card,
      size: 30.0,
      color: Colors.grey[600],
    );
    switch (cardType) {
      case CardType.Master:
        img = Assets.masterCardIcon;
        break;
      case CardType.Visa:
        img = Assets.visaCardIcon;
        break;
      case CardType.Verve:
        img = 'verve.png';
        break;
      case CardType.AmericanExpress:
        img = Assets.americanExpressCardIcon;
        break;
      case CardType.Discover:
        img = Assets.discoverCardIcon;
        break;
      case CardType.DinersClub:
        img = 'dinners_club.png';
        break;
      case CardType.Jcb:
        img = 'jcb.png';
        break;
      case CardType.Others:
        icon = new Icon(
          Icons.credit_card,
          size: 30.0,
          color: Colors.grey[600],
        );
        break;
      default:
        icon = new Icon(
          Icons.credit_card,
          size: 30.0,
          color: Colors.grey[600],
        );
        break;
    }
    Widget widget;
    if (img.isNotEmpty) {
      widget = new Image.asset(
        '$img',
        height: 10.0,
        width: 10.0,
      );
    } else {
      widget = icon;
    }
    return widget;
  }


  static Widget getCardIconforUserScreen(String cardType) {
    String img = "";
    Icon icon= new Icon(
      Icons.credit_card,
      size: 40.0,
      color: Colors.grey[600],
    );
    switch (cardType) {
      case 'MasterCard':
        img = Assets.masterCardIcon;
        break;
      case 'Visa':
        img = Assets.visaCardIcon;
        break;
      case 'Verve':
        img = 'verve.png';
        break;
      case 'AmericanExpress':
        img = Assets.americanExpressCardIcon;
        break;
      case 'Discover':
        img = Assets.discoverCardIcon;
        break;
      case 'DinersClub':
        img = 'dinners_club.png';
        break;
      case 'Jcb':
        img = 'jcb.png';
        break;
      case 'Others':
        icon = new Icon(
          Icons.credit_card,
          size: 40.0,
          color: Colors.grey[600],
        );
        break;
      default:
        icon = new Icon(
          Icons.credit_card,
          size: 40.0,
          color: Colors.grey[600],
        );
        break;
    }
    Widget widget;
    if (img.isNotEmpty) {
      widget = new Image.asset(
        'images/$img',
        width: 40.0,
      );
    } else {
      widget = icon;
    }
    return widget;
  }


  /// With the card number with Luhn Algorithm
  /// https://en.wikipedia.org/wiki/Luhn_algorithm
  static String? validateCardNum(String input) {
    if (input == null || input.isEmpty) {
      return "This field is required";
    }

    input = getCleanedNumber(input);

    if (input.length < 8) {
      return "Number is invalid";
    }

    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(input[length - i - 1]);

      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return null;
    }

    return "Number is invalid";
  }

  static CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(new RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.Master;
    } else if (input.startsWith(new RegExp(r'[4]'))) {
      cardType = CardType.Visa;
    } else if (input.startsWith(new RegExp(r'((34)|(37))'))) {
      cardType = CardType.AmericanExpress;
    } else if (input.startsWith(new RegExp(r'((6[45])|(6011))'))) {
      cardType = CardType.Discover;
    } else if (input
        .startsWith(new RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
      cardType = CardType.DinersClub;
    } else if (input.startsWith(new RegExp(r'(352[89]|35[3-8][0-9])'))) {
      cardType = CardType.Jcb;
    } else if (input.length <= 8) {
      cardType = CardType.Others;
    } else {
      cardType = CardType.Invalid;
    }
    return cardType;
  }
}
