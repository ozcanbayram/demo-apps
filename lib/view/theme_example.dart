import 'package:delivery_app/core/const/project_texts.dart';
import 'package:flutter/material.dart';

// Bu safa temadaki bazı temel deişikliklerin görünmü var. Ve bu saya daha sonra ilinecek.

class ThemeExamlView extends StatefulWidget {
  const ThemeExamlView({super.key});

  @override
  State<ThemeExamlView> createState() => _ThemeExamlViewState();
}

class _ThemeExamlViewState extends State<ThemeExamlView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ProjectTexts.appName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('displayLarge',
                style: Theme.of(context).textTheme.displayLarge),
            Text('displayMedium',
                style: Theme.of(context).textTheme.displayMedium),
            Text('displaySmall',
                style: Theme.of(context).textTheme.displaySmall),
            Text('headlineLarge',
                style: Theme.of(context).textTheme.headlineLarge),
            Text('headlineMedium',
                style: Theme.of(context).textTheme.headlineMedium),
            Text('headlineSmall',
                style: Theme.of(context).textTheme.headlineSmall),
            Text('dabodySmallta', style: Theme.of(context).textTheme.bodySmall),
            Text('bodyMedium', style: Theme.of(context).textTheme.bodyMedium),
            Text('bodyLarge', style: Theme.of(context).textTheme.bodyLarge),
            Text('labelSmall', style: Theme.of(context).textTheme.labelSmall),
            Text('labelMedium', style: Theme.of(context).textTheme.labelMedium),
            Text('labelLarge', style: Theme.of(context).textTheme.labelLarge),
            Text('titleLarge', style: Theme.of(context).textTheme.titleLarge),
            Text('titleMedium', style: Theme.of(context).textTheme.titleMedium),
            Text('titleSmall', style: Theme.of(context).textTheme.titleSmall),
            ElevatedButton(onPressed: () {}, child: Text('data')),
           
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
