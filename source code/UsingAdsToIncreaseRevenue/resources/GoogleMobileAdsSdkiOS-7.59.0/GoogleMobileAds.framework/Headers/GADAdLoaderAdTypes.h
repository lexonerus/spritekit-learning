/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADAdLoaderAdTypes.h
//  Google Mobile Ads SDK
//
//  Copyright 2015 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAdsDefines.h>

typedef NSString *GADAdLoaderAdType NS_STRING_ENUM;

/// Use with GADAdLoader to request native custom template ads. To receive ads, the ad loader's
/// delegate must conform to the GADNativeCustomTemplateAdLoaderDelegate protocol. See
/// GADNativeCustomTemplateAd.h.
GAD_EXTERN GADAdLoaderAdType _Nonnull const kGADAdLoaderAdTypeNativeCustomTemplate;

/// Use with GADAdLoader to request Google Ad Manager banner ads. To receive ads, the ad loader's
/// delegate must conform to the DFPBannerAdLoaderDelegate protocol. See DFPBannerView.h.
GAD_EXTERN GADAdLoaderAdType _Nonnull const kGADAdLoaderAdTypeDFPBanner;

/// Use with GADAdLoader to request native ads. To receive ads, the ad loader's delegate must
/// conform to the GADUnifiedNativeAdLoaderDelegate protocol. See GADUnifiedNativeAd.h.
GAD_EXTERN GADAdLoaderAdType _Nonnull const kGADAdLoaderAdTypeUnifiedNative;
