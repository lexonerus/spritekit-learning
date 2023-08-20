/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  DFPCustomRenderedAd.h
//  Google Mobile Ads SDK
//
//  Copyright 2014 Google LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Custom rendered ad. Your application renders the ad.
@interface DFPCustomRenderedAd : NSObject

/// The ad's HTML.
@property(nonatomic, readonly, nonnull) NSString *adHTML;

/// The base URL of the ad's HTML.
@property(nonatomic, readonly, nonnull) NSURL *adBaseURL;

/// Call this method when the user clicks the ad.
- (void)recordClick;

/// Call this method when the ad is visible to the user.
- (void)recordImpression;

/// Call this method after the ad has been rendered in a UIView object.
- (void)finishedRenderingAdView:(nonnull UIView *)view;

@end
