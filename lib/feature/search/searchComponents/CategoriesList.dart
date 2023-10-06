import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/text600normal.dart';

class CategoriesList extends StatefulWidget {
  final ValueChanged<String>? onCategorySelected;

  const CategoriesList({Key? key, this.onCategorySelected}) : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  String selectedCategory = 'all';

  List<CategoryItem> categories = [
    CategoryItem('all', 'categoryall.svg', true, language[defaultLang]['all']),
    CategoryItem('Family Consultant', 'familyconsultingicon.svg', false,
        language[defaultLang]['familyconsultant']),
    CategoryItem('Educationnal Consultant', 'educationnalconsultanticon.svg',
        false, language[defaultLang]['educationnalconsultant']),
    CategoryItem('Psychological Consultant', 'psychologicalconsultanticon.svg',
        false, language[defaultLang]['psychologicalconsultant']),
    CategoryItem('Professional Consultant', 'professionalconsultanticon.svg',
        false, language[defaultLang]['professionalconsultant']),
    CategoryItem('Human Development', 'humandevelopmenticon.svg', false,
        language[defaultLang]['humandevelopment']),
    CategoryItem('Behavior Consultant', 'behaviorconsultanticon.svg', false,
        language[defaultLang]['behaviorconsultant']),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 8),
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories.map((category) {
          return GestureDetector(
            onTap: () {
              setState(() {
                for (var otherCategory in categories) {
                  if (otherCategory != category) {
                    otherCategory.isSelected = false;
                  }
                }
                category.isSelected = true;
                selectedCategory = category.name;
              });
              widget.onCategorySelected?.call(selectedCategory);
            },
            child: _categoryItem(
              category.title,
              category.image,
              category.isSelected,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _categoryItem(String categoryName, String image, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? cyan : lightblack, width: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(13)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          SvgPicture.asset('assets/images/$image'),
          const SizedBox(width: 5),
          text600normal(
            text: categoryName,
            color: isSelected ? cyan : darkblack,
            fontsize: 14,
          ),
        ],
      ),
    );
  }
}

class CategoryItem {
  final String name;
  final String image;
  bool isSelected;
  String title;
  CategoryItem(this.name, this.image, this.isSelected, this.title);
}
