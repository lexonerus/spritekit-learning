/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  DFPBannerViewOptions.h
//  Google Mobile Ads SDK
//
//  Copyright 2016 Google LLC. All rights reserved.
//

#import <GoogleMobileAds/GADAdLoader.h>
#import <GoogleMobileAds/GADAdSize.h>
#import <GoogleMobileAds/GADAdSizeDelegate.h>
#import <GoogleMobileAds/GADAppEventDelegate.h>

/// Ad loader options for banner ads.
@interface DFPBannerViewOptions : GADAdLoaderOptions

/// Optional delegate that is notified if the loaded banner sends app events.
@property(nonatomic, weak, nullable) id<GADAppEventDelegate> appEventDelegate;

/// Optional delegate that is notified if the loaded banner changes size.
@property(nonatomic, weak, nullable) id<GADAdSizeDelegate> adSizeDelegate;

/// Whether the publisher will record impressions manually when the ad becomes visible to the user.
@property(nonatomic, assign) BOOL enableManualImpressions;

@end
