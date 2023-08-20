/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  DFPCustomRenderedBannerViewDelegate.h
//  Google Mobile Ads SDK
//
//  Copyright 2014 Google LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DFPBannerView;
@class DFPCustomRenderedAd;

/// The DFPCustomRenderedAd banner view delegate protocol for notifying the delegate of changes to
/// custom rendered banners.
@protocol DFPCustomRenderedBannerViewDelegate <NSObject>

/// Called after ad data has been received. You must construct a banner from |customRenderedAd| and
/// call the |customRenderedAd| object's finishedRenderingAdView: when the ad has been rendered.
- (void)bannerView:(nonnull DFPBannerView *)bannerView
    didReceiveCustomRenderedAd:(nonnull DFPCustomRenderedAd *)customRenderedAd;

@end
