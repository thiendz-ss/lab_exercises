import 'package:flutter/material.dart';

class GridDemoScreen extends StatelessWidget {
  const GridDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GridView Exercise"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// -------------------------
            /// FIXED COLUMN GRID
            /// -------------------------
            Text(
              "Fixed Column Grid",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(12, (index) {
                return _buildGridItem(index + 1);
              }),
            ),

            const SizedBox(height: 25),

            /// -------------------------
            /// RESPONSIVE GRID (MAX EXTENT)
            /// -------------------------
            Text(
              "Responsive Grid",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            GridView.extent(
              maxCrossAxisExtent: 150,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(12, (index) {
                return _buildGridItem(index + 1);
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget for each grid item
  Widget _buildGridItem(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image, size: 40, color: Colors.blue),
          const SizedBox(height: 8),
          Text("Item $index"),
        ],
      ),
    );
  }
}
