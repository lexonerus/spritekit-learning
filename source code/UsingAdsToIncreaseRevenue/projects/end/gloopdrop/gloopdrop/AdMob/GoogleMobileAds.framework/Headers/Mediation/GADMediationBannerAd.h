/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADMediationBannerAd.h
//  Google Mobile Ads SDK
//
//  Copyright 2018 Google LLC. All rights reserved.
//

#import <GoogleMobileAds/GADAdSize.h>
#import <GoogleMobileAds/Mediation/GADMediationAd.h>
#import <GoogleMobileAds/Mediation/GADMediationAdConfiguration.h>
#import <GoogleMobileAds/Mediation/GADMediationAdEventDelegate.h>
#import <UIKit/UIKit.h>

/// Rendered banner ad. Provides a single subview to add to the banner view's view hierarchy.
@protocol GADMediationBannerAd <GADMediationAd>

/// The banner ad view.
@property(nonatomic, readonly, nonnull) UIView *view;

@optional

/// Tells the ad to resize the banner. Implement if banner content is resizable.
- (void)changeAdSizeTo:(GADAdSize)adSize;
@end

/// Banner ad configuration.
@interface GADMediationBannerAdConfiguration : GADMediationAdConfiguration

/// Banner ad size requested of the adapter.
@property(nonatomic, readonly) GADAdSize adSize;

@end
