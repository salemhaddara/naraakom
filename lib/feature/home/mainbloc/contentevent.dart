// ignore_for_file: camel_case_types

abstract class contentevent {}

class ConsultantsRequested extends contentevent {}

class SelectCategoryEvent extends contentevent {
  final String selectedCategory;

  SelectCategoryEvent(this.selectedCategory);
}

class SearchtextChangedEvent extends contentevent {
  final String? text;
  final String selectedCategory;

  SearchtextChangedEvent(this.text, this.selectedCategory);
}
