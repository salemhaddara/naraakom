// ignore_for_file: camel_case_types

abstract class profilestatus {}

class initialstatus extends profilestatus {}

class logoutSuccess extends profilestatus {}

class logoutLoading extends profilestatus {}

class logoutfailed extends profilestatus {
  String message;
  logoutfailed(this.message);
}
