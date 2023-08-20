/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADCustomEventBanner.h
//  Google Mobile Ads SDK
//
//  Copyright 2012 Google LLC. All rights reserved.
//

#import <GoogleMobileAds/GADAdSize.h>
#import <GoogleMobileAds/GADCustomEventBannerDelegate.h>
#import <GoogleMobileAds/GADCustomEventRequest.h>
#import <UIKit/UIKit.h>

/// The banner custom event protocol. Your banner custom event handler must implement this protocol.
@protocol GADCustomEventBanner <NSObject>

/// Inform |delegate| with the custom event execution results to ensure mediation behaves correctly.
///
/// In your class, define the -delegate and -setDelegate: methods or use "@synthesize delegate". The
/// Google Mobile Ads SDK sets this property on instances of your class.
@property(nonatomic, weak, nullable) id<GADCustomEventBannerDelegate> delegate;

/// Returns an initialized custom event banner.
- (nonnull instancetype)init;

/// Called by mediation when your custom event is scheduled to be executed. Report execution results
/// to the delegate.
///
/// @param adSize The size of the ad as configured in the mediation UI for the mediation placement.
/// @param serverParameter Parameter configured in the mediation UI.
/// @param serverLabel Label configured in the mediation UI.
/// @param request Contains ad request information.
- (void)requestBannerAd:(GADAdSize)adSize
              parameter:(nullable NSString *)serverParameter
                  label:(nullable NSString *)serverLabel
                request:(nonnull GADCustomEventRequest *)request;

@end
