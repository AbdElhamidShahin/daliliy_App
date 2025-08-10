import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CategoryDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final Function(String?) onChanged;

  const CategoryDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: const Row(
            children: [
              Icon(Icons.list, size: 24, color: Colors.white),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  'اختر الفئة',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    alignment: Alignment.centerRight, // يضمن المحاذاة لليمين

                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        item,
                        textAlign: TextAlign.right, // النص نفسه يبدأ من اليمين

                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: onChanged,
          buttonStyleData: ButtonStyleData(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.black26),
              color: Colors.lightBlue,
            ),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_forward_ios_outlined),
            iconSize: 24,
            iconEnabledColor: Colors.white,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.blueGrey,
            ),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
        ),
      ),
    );
  }
}
