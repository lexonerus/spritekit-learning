/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADDelayedAdRenderingOptions.h
//  Google Mobile Ads SDK
//
//  Copyright 2018 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GADAdLoader.h>

/// Delegate for delayed rendering of Google banner ads.
@protocol GADDelayedAdRenderingDelegate <NSObject>

/// Asks the delegate whether the ad loader should delay rendering the banner ad that it's chosen.
/// If the delegate returns YES, it must also call resumeHandler when it is ready for rendering to
/// resume.
- (BOOL)adLoader:(nonnull GADAdLoader *)adLoader
    shouldDelayRenderingWithResumeHandler:(nonnull dispatch_block_t)resumeHandler;

@end

/// Ad loader options for configuring delayed rendering of Google banner ads.
@interface GADDelayedAdRenderingOptions : GADAdLoaderOptions

/// Delegate for delaying the rendering of Google banner ads.
@property(nonatomic, nullable, weak) id<GADDelayedAdRenderingDelegate> delegate;

@end
