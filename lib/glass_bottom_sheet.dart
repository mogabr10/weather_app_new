import 'dart:ui';
import 'package:flutter/material.dart';

class GlassBottomSheet extends StatelessWidget {
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;

  /// Tab configuration
  final List<String>? tabs; // Titles of tabs
  final List<Widget>? tabViews; // Widgets for each tab

  /// Builder for non-tab content
  final Widget Function(BuildContext, ScrollController)? builder;

  /// Customizations
  final Gradient? gradient;
  final BorderRadiusGeometry borderRadius;
  final String? noiseAsset;
  final double noiseOpacity;
  final double blurSigma;

  const GlassBottomSheet({
    super.key,
    this.initialChildSize = 0.3,
    this.minChildSize = 0.2,
    this.maxChildSize = 0.8,
    this.tabs,
    this.tabViews,
    this.builder,
    this.gradient,
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(30),
    ),
    this.noiseAsset,
    this.noiseOpacity = 0.05,
    this.blurSigma = 15,
  }) : assert(
         (tabs != null && tabViews != null && tabs.length == tabViews.length) ||
             builder != null,
         'Either provide tabs and tabViews of equal length, or a builder function',
       );

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: Stack(
              children: [
                // Gradient background
                Container(
                  decoration: BoxDecoration(
                    gradient:
                        gradient ??
                        LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.white.withOpacity(0.05),
                          ],
                        ),
                    borderRadius: borderRadius,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                ),

                // Optional noise overlay
                if (noiseAsset != null)
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(noiseAsset!),
                        repeat: ImageRepeat.repeat,
                        opacity: noiseOpacity,
                      ),
                    ),
                  ),

                // Content: Either Tabs or Builder
                if (tabs != null && tabViews != null)
                  DefaultTabController(
                    length: tabs!.length,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white70,
                          indicatorColor: Colors.white,
                          tabs: tabs!.map((t) => Tab(text: t)).toList(),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: tabViews!
                                .map(
                                  (tabView) => SingleChildScrollView(
                                    controller: scrollController,
                                    child: tabView,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                else if (builder != null)
                  builder!(context, scrollController),
              ],
            ),
          ),
        );
      },
    );
  }
}
