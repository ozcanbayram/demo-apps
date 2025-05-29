import 'package:delivery_app/core/const/project_colors.dart';
import 'package:delivery_app/core/const/project_texts.dart';
import 'package:delivery_app/product/custom/widgets/custom_padding.dart';
import 'package:delivery_app/product/custom/widgets/custom_text_field.dart';
import 'package:delivery_app/product/custom/widgets/custom_text_button.dart';
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
    "Fruits",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: CustomPadding.horizontalMedium(),
              child: Text(
                ProjectTexts.feedTitle,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(),
              ),
            ),
            const SizedBox(height: 20),
            CustomSearchField(),
            const SizedBox(height: 20),
            _buildCategoryMenu(),
            _buildHorizontalProductList(),
          ],
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
                      color: ProjectColors.primary,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHorizontalProductList() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox.shrink(),
            CustomTextButton(
              onPressed: () {},
              title: "See More",
              selectedMaker: false,
              color: ProjectColors.primary,
            ),
          ],
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return _buildCard(context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: 200,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 100, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Product Name',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '\$25.00',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ProjectColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      minimumSize: const Size.fromHeight(36),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 0,
            child: CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage('https://picsum.photos/200'),
            ),
          ),
        ],
      ),
    );
  }
}
