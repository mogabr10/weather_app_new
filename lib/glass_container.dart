import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blurSigma;
  final Gradient? gradient;
  final BorderRadiusGeometry borderRadius;
  final String? noiseAsset;
  final double noiseOpacity;
  final double width;
  final double height;

  const GlassContainer({
    super.key,
    required this.child,
    this.blurSigma = 10.0,
    this.gradient,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.noiseAsset,
    this.noiseOpacity = 0.05,
    this.width = 60,
    this.height = 146,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          width: width,
          height: height,
          // color: Colors.white.withOpacity(0.1),
          decoration: BoxDecoration(
            gradient: gradient ?? _defaultGradient,
            borderRadius: borderRadius,
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              if (noiseAsset != null)
                Positioned.fill(
                  child: Opacity(
                    opacity: noiseOpacity,
                    child: Image.asset(noiseAsset!, fit: BoxFit.cover),
                  ),
                ),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Gradient get _defaultGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)],
  );
}
