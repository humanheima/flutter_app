import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../constant/textsize_const.dart';
import '../../model/HomeResponse.dart';

/// RecommendBanner
///
/// A reusable banner / image swiper widget extracted from `project_list_page2.dart`.
///
/// Purpose:
/// - Render a list of `RecBanner` items as a horizontal swiper (single item viewport).
/// - Show the current banner title on top of the images and a dot pagination at the right.
///
/// Public API:
/// - `banners` (required): the list of `RecBanner` objects to display. The `RecBanner` model
///    in this project has non-nullable fields (title, resourceUrl, destUrl), so this widget
///    treats those properties as non-null.
/// - `height` (optional): the height of the widget (defaults to 124).
///
/// Notes / behavior:
/// - If `banners` is empty the widget renders to a zero-height placeholder (`SizedBox.shrink()`).
/// - This widget uses the `card_swiper` package; make sure `card_swiper` is present in
///   `pubspec.yaml` (this project already includes it).
/// - Currently the widget only displays images and title + pagination. It does not handle
///   taps or navigation — you can extend it to handle clicks (e.g., open `destUrl`) if desired.
///
/// Example usage:
/// ```dart
/// RecommendBanner(banners: myListOfRecBanner, height: 140);
/// ```
class RecommendBanner extends StatefulWidget {
  /// Banners to display. Each `RecBanner` holds the image URL and title.
  final List<RecBanner> banners;

  /// Widget height. Defaults to 124 which matches the previous layout.
  final double height;

  const RecommendBanner({Key? key, required this.banners, this.height = 124}) : super(key: key);

  @override
  _RecommendBannerState createState() => _RecommendBannerState();
}

class _RecommendBannerState extends State<RecommendBanner> {
  // Controller is kept internal to allow programmatic control if needed later.
  final SwiperController _controller = SwiperController();

  /// Build a custom pagination widget for the swiper.
  ///
  /// It shows the current banner's `title` on the left and a dot pagination on the right.
  SwiperPagination _pagination() => SwiperPagination(
        margin: EdgeInsets.all(0.0),
        builder: SwiperCustomPagination(builder: (BuildContext context, SwiperPluginConfig config) {
          // If there are no banners, don't render the pagination overlay.
          if (widget.banners.isEmpty) {
            return SizedBox.shrink();
          }

          // `config.activeIndex` indicates the currently visible page.
          // Guard against unexpected indices (defensive programming).
          final activeIndex = config.activeIndex;
          final title = (activeIndex >= 0 && activeIndex < widget.banners.length)
              ? widget.banners[activeIndex].title
              : '';

          // Overlay container with semi-transparent background to ensure title readability.
          return Container(
            color: Colors.black45,
            height: 40,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: <Widget>[
                // Banner title (left aligned)
                Text(
                  title,
                  style: TextStyle(fontSize: TextSizeConst.smallTextSize, color: Colors.white),
                ),
                // Dot pagination (right aligned)
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: DotSwiperPaginationBuilder(
                            color: Colors.white70, activeColor: Colors.green, size: 6.0, activeSize: 6.0)
                        .build(context, config),
                  ),
                )
              ],
            ),
          );
        }),
      );

  @override
  Widget build(BuildContext context) {
    // The outer container ensures the widget takes a consistent height in the layout.
    return Container(
      height: widget.height,
      child: widget.banners.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Swiper(
                // Autoplay is disabled by default to match original behavior.
                autoplay: false,
                autoplayDelay: 3500,
                controller: _controller,
                itemHeight: widget.height,
                pagination: _pagination(),
                // Build each swiper item as a full-bleed image. Defensive index checks
                // ensure we don't access out-of-range entries if the swiper reports an
                // unexpected index.
                itemBuilder: (BuildContext context, int index) {
                  final imageUrl = (index >= 0 && index < widget.banners.length)
                      ? widget.banners[index].resourceUrl
                      : '';
                  if (imageUrl.isEmpty) {
                    // Fallback placeholder for missing image URLs.
                    return Container(color: Colors.grey[200]);
                  }
                  // Use Image.network directly — you may provide a custom image loader
                  // or use CachedNetworkImage for caching/placeholder/error handling.
                  return Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                  );
                },
                itemCount: widget.banners.length,
                loop: false,
                viewportFraction: 1.0,
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
