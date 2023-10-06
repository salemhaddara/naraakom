abstract class contentevent {}

class ConsultantsRequested extends contentevent {}

class UserDataRequested extends contentevent {}

class SelectCategoryEvent extends contentevent {
  final String selectedCategory;

  SelectCategoryEvent(this.selectedCategory);
}

class SearchtextChangedEvent extends contentevent {
  final String? text;
  final String selectedCategory;

  SearchtextChangedEvent(this.text, this.selectedCategory);
}
