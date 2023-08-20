/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADNativeAdImageAdLoaderOptions.h
//  Google Mobile Ads SDK
//
//  Copyright 2015 Google LLC. All rights reserved.
//

#import <GoogleMobileAds/GADAdLoader.h>

/// Native ad image orientation preference.
typedef NS_ENUM(NSInteger, GADNativeAdImageAdLoaderOptionsOrientation) {
  GADNativeAdImageAdLoaderOptionsOrientationAny = 1,       ///< No orientation preference.
  GADNativeAdImageAdLoaderOptionsOrientationPortrait = 2,  ///< Prefer portrait images.
  GADNativeAdImageAdLoaderOptionsOrientationLandscape = 3  ///< Prefer landscape images.
};

/// Ad loader options for native ad image settings.
@interface GADNativeAdImageAdLoaderOptions : GADAdLoaderOptions

/// Indicates whether image asset content should be loaded by the SDK. If set to YES, the SDK will
/// not load image asset content and native ad image URLs can be used to fetch content. Defaults to
/// NO, image assets are loaded by the SDK.
@property(nonatomic, assign) BOOL disableImageLoading;

/// Indicates whether multiple images should be loaded for each asset. Defaults to NO.
@property(nonatomic, assign) BOOL shouldRequestMultipleImages;

#pragma mark - Deprecated

/// Indicates preferred image orientation. Defaults to
/// GADNativeAdImageAdLoaderOptionsOrientationAny.
@property(nonatomic, assign)
    GADNativeAdImageAdLoaderOptionsOrientation preferredImageOrientation DEPRECATED_MSG_ATTRIBUTE(
        "Use the mediaAspectRatio property from GADNativeAdMediaAdLoaderOptions instead.");

@end
