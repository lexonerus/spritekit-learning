/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADInstreamAd.h
//  Google Mobile Ads SDK
//
//  Copyright 2019 Google LLC. All rights reserved.
//

#import <GoogleMobileAds/GADAdValue.h>
#import <GoogleMobileAds/GADMediaAspectRatio.h>
#import <GoogleMobileAds/GADMediaContent.h>
#import <GoogleMobileAds/GADRequest.h>
#import <GoogleMobileAds/GADResponseInfo.h>
#import <GoogleMobileAds/GADVideoController.h>
#import <UIKit/UIKit.h>

@class GADInstreamAd;

/// Instream ad load completion handler. On load success, |instreamAd| is the non-nil instream ad
/// and |error| is nil. On load failure, |instreamAd| is nil and |error| provides failure
/// information.
typedef void (^GADInstreamAdLoadCompletionHandler)(GADInstreamAd *_Nullable instreamAd,
                                                   NSError *_Nullable error);

/// An instream ad.
@interface GADInstreamAd : NSObject

/// Loads an instream ad with the provided ad unit ID. Instream ads only support
/// GADMediaAspectRatioLandscape and GADMediaAspectRatioPortrait media aspect ratios, defaulting to
/// GADMediaAspectRatioLandscape. Calls the provided completion handler when the ad load completes.
+ (void)loadAdWithAdUnitID:(nonnull NSString *)adUnitID
                   request:(nullable GADRequest *)request
          mediaAspectRatio:(GADMediaAspectRatio)mediaAspectRatio
         completionHandler:(nonnull GADInstreamAdLoadCompletionHandler)completionHandler;

/// Loads an instream ad with the provided ad tag. Calls the provided completion handler when the
/// ad load completes.
+ (void)loadAdWithAdTag:(nonnull NSString *)adTag
      completionHandler:(nonnull GADInstreamAdLoadCompletionHandler)completionHandler;

/// Media content metadata and controls.
@property(nonatomic, readonly, nonnull) GADMediaContent *mediaContent;

/// Information about the ad response that returned the ad.
@property(nonatomic, readonly, nonnull) GADResponseInfo *responseInfo;

/// Called when the ad is estimated to have earned money. Available for whitelisted accounts only.
@property(nonatomic, nullable, copy) GADPaidEventHandler paidEventHandler;

@end
