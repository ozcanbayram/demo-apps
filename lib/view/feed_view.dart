import 'package:delivery_app/core/const/project_colors.dart';
import 'package:delivery_app/core/const/project_texts.dart';
import 'package:delivery_app/product/custom/widgets/custom_padding.dart';
import 'package:delivery_app/product/custom/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  final List<String> categories = [
    "Food",
    "Drinks",
    "Snacks",
    "Desserts",
    "Fruits"
  ];
  String selectedCategory = "Food"; // Varsayılan olarak seçili kategori

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Menü butonuna tıklanınca yapılacak işlemler
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: ProjectColors.textSecondary,
            ),
            onPressed: () {
              // Sepet butonuna tıklanınca yapılacak işlemler
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: CustomPadding.all(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ProjectTexts.feedTitle,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(),
              ),
              CustomSearchField(),
              _buildCategoryMenu(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryMenu() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = category == selectedCategory;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category; // Seçili kategoriyi güncelle
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    category,
                    style: TextStyle(
                      color: isSelected
                          ? ProjectColors.primary
                          : ProjectColors.textSecondary,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  if (isSelected)
                    Container(
                      margin: const EdgeInsets.only(top: 4.0),
                      height: 2.0,
                      width: 50.0,
                      color: ProjectColors.primary, // Turuncu çizgi
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
