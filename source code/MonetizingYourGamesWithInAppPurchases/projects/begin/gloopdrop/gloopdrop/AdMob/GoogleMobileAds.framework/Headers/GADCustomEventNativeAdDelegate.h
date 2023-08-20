/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADCustomEventNativeAdDelegate.h
//  Google Mobile Ads SDK
//
//  Copyright 2015 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GADCustomEventNativeAd.h>
#import <GoogleMobileAds/Mediation/GADMediatedUnifiedNativeAd.h>

/// The delegate of the GADCustomEventNativeAd object must adopt the GADCustomEventNativeAdDelegate
/// protocol. Methods in this protocol are used for native ad's custom event communication with the
/// Google Mobile Ads SDK.
@protocol GADCustomEventNativeAdDelegate <NSObject>

/// Tells the delegate that the custom event ad request failed.
- (void)customEventNativeAd:(nonnull id<GADCustomEventNativeAd>)customEventNativeAd
     didFailToLoadWithError:(nonnull NSError *)error;

/// Tells the delegate that the custom event ad request succeeded and loaded a unified native ad.
- (void)customEventNativeAd:(nonnull id<GADCustomEventNativeAd>)customEventNativeAd
    didReceiveMediatedUnifiedNativeAd:
        (nonnull id<GADMediatedUnifiedNativeAd>)mediatedUnifiedNativeAd;

@end
