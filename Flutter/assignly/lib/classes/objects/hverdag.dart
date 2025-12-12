enum Hverdag {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday
}

extension HverdagExtension on Hverdag {
  int get value {
    int value;
    switch (this) {
      case Hverdag.monday:
        value = 0;
      case Hverdag.tuesday:
        value = 1;
      case Hverdag.wednesday:
        value = 2;
      case Hverdag.thursday:
        value = 3;
      case Hverdag.friday:
        value = 4;
      case Hverdag.saturday:
        value = 5;
      case Hverdag.sunday:
        value = 6;
    }
    return value;
  }

  static Hverdag fromInt(int value) {
    switch (value) {
      case 0:
        return Hverdag.monday;
      case 1:
        return Hverdag.tuesday;
      case 2:
        return Hverdag.wednesday;
      case 3:
        return Hverdag.thursday;
      case 4:
        return Hverdag.friday;
      case 5:
        return Hverdag.saturday;
      case 6:
        return Hverdag.sunday;
      default:
        return Hverdag.monday;
    }
  }
}

