/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADNativeAdMediaAdLoaderOptions.h
//  Google Mobile Ads SDK
//
//  Copyright 2019 Google LLC. All rights reserved.
//

#import <GoogleMobileAds/GADAdLoader.h>
#import <GoogleMobileAds/GADMediaAspectRatio.h>

/// Ad loader options for native ad media settings.
@interface GADNativeAdMediaAdLoaderOptions : GADAdLoaderOptions

/// Image and video aspect ratios. Defaults to GADMediaAspectRatioUnknown. Portrait, landscape, and
/// square aspect ratios are returned when this property is GADMediaAspectRatioUnknown or
/// GADMediaAspectRatioAny.
@property(nonatomic, assign) GADMediaAspectRatio mediaAspectRatio;

@end
