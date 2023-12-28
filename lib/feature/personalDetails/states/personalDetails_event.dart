// ignore_for_file: camel_case_types, file_names

abstract class personalDetails_event {}

class fetchDetails extends personalDetails_event {}

class updateDetails extends personalDetails_event {
  Map<String, dynamic> dataForUpdate;
  updateDetails(this.dataForUpdate);
}
