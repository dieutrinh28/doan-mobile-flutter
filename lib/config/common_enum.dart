enum MedicineType {
  Tablet,
  Capsules,
  Syrup,
  Liquid,
}


extension MedicineTypeExtension on MedicineType {
  static int toInt(MedicineType value) {
    switch (value) {
      case MedicineType.Tablet:
        return 0;
      case MedicineType.Capsules:
        return 1;
      case MedicineType.Syrup:
        return 2;
      case MedicineType.Liquid:
        return 3;
      default:
        return 100;
    }
  }
  static MedicineType fromInt(int value) {
    switch(value) {
      case 0:
        return MedicineType.Tablet;
      case 1:
        return MedicineType.Capsules;
      case 2:
        return MedicineType.Syrup;
      case 3:
        return MedicineType.Liquid;
      default:
        throw Exception("Unsupported MedicineType value: $value");
    }
  }
}

String medicineTypeToString(MedicineType medicineType) {
  return medicineType.toString().split('.').last;
}

enum DoseType {
  pills,
  mg,
  ml,
}

extension DoseTypeExtension on DoseType {
  static int toInt(DoseType value) {
    switch (value) {
      case DoseType.pills:
        return 0;
      case DoseType.mg:
        return 1;
      case DoseType.ml:
        return 2;
      default:
        return 100;
    }
  }
  static DoseType fromInt(int value) {
    switch(value) {
      case 0:
        return DoseType.pills;
      case 1:
        return DoseType.mg;
      case 2:
        return DoseType.ml;
      default:
        throw Exception("Unsupported DoseType value: $value");
    }
  }
}


String doseTypeToString(DoseType doseType) {
  return doseType.toString().split('.').last;
}


