// ignore_for_file: camel_case_types

abstract class specialistsrequeststate {}

class specialistsFetchingSUCCESSFUL extends specialistsrequeststate {}

class specialistsFetchingFAILED extends specialistsrequeststate {
  String exception;
  specialistsFetchingFAILED(this.exception);
}

class specialistsFetchingLOADING extends specialistsrequeststate {}

class specialistsFetchingINITIAL extends specialistsrequeststate {}
