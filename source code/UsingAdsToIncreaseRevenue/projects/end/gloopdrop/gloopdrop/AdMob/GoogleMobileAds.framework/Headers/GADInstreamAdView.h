/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADInstreamAdView.h
//  Google Mobile Ads SDK
//
//  Copyright 2019 Google LLC. All rights reserved.
//

#import <GoogleMobileAds/GADInstreamAd.h>

/// A view that displays instream video ads.
@interface GADInstreamAdView : UIView

/// The instream ad. The ad will begin playing when the GADInstreamAdView is visible.
@property(nonatomic, nullable) GADInstreamAd *ad;

@end
