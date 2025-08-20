import 'package:fetchhing_demo/custom/post_card_widget.dart';
import 'package:fetchhing_demo/models/post_model.dart';
import 'package:fetchhing_demo/services/api_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  FutureBuilder<List<Post>> fetchPostItems() {
    return FutureBuilder<List<Post>>(
      future: ApiService.fetchPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator(); // Yükleniyor
        } else if (snapshot.hasError) {
          return Center(child: Text("Hata: ${snapshot.error}")); // Hata
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Veri bulunamadı")); // Veri boş
        } else {
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return CustomPostCard(post: post);
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts List")),
      body: fetchPostItems(),
    );
  }
}
