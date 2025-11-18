# flutter_staggered_grid_view demos

This folder contains example pages that demonstrate the different layouts
provided by the `flutter_staggered_grid_view` package. Each file is a small
standalone `Widget` you can push from your app to inspect the layout.

Files:
- `staggered_index.dart` — index page that links to each demo.
- `staggered_demo.dart` — `StaggeredGrid.count` example.
- `masonry_demo.dart` — `MasonryGridView.count` example.
- `quilted_demo.dart` — `SliverQuiltedGridDelegate` example via `GridView.custom`.
- `woven_demo.dart` — `SliverWovenGridDelegate` example via `GridView.custom`.
- `staired_demo.dart` — `SliverStairedGridDelegate` example via `GridView.custom`.
- `aligned_demo.dart` — `AlignedGridView.count` example.
- `demo_tile.dart` — small reusable tile used by demos.

How to use:
1. From your app, navigate to the index page, e.g.:

```dart
Navigator.push(context, MaterialPageRoute(builder: (_) => StaggeredDemosIndex()));
```

2. Tap any demo to open it.

Notes:
- These demos are minimal and intended for local experimentation.
- Ensure `flutter_staggered_grid_view` is present in your `pubspec.yaml`.
