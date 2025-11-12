// 演示如何集成WebView功能到现有应用
import 'package:flutter/material.dart';
import 'web_demos.dart';

class MainAppWithWebDemo extends StatelessWidget {
  const MainAppWithWebDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App with WebView Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildDemoCard(
              context,
              title: 'WebView 交互',
              icon: Icons.web,
              color: Colors.blue,
              description: 'Flutter与WebView双向通信演示',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const WebDemoEntryPage(),
                  ),
                );
              },
            ),
            _buildDemoCard(
              context,
              title: '登录演示',
              icon: Icons.login,
              color: Colors.green,
              description: 'Figma设计的登录页面',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('登录演示功能')),
                );
              },
            ),
            _buildDemoCard(
              context,
              title: '动画效果',
              icon: Icons.animation,
              color: Colors.orange,
              description: 'Flutter动画演示',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('动画演示功能')),
                );
              },
            ),
            _buildDemoCard(
              context,
              title: '自定义组件',
              icon: Icons.widgets,
              color: Colors.purple,
              description: '自定义Widget演示',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('自定义组件演示')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 你可以将这个作为main函数使用来测试完整的应用
void main() {
  runApp(const MainAppWithWebDemo());
}
