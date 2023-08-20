/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADVideoOptions.h
//  Google Mobile Ads SDK
//
//  Copyright 2016 Google LLC. All rights reserved.
//

#import <GoogleMobileAds/GADAdLoader.h>

/// Video ad options.
@interface GADVideoOptions : GADAdLoaderOptions

/// Indicates whether videos should start muted. By default this property value is YES.
@property(nonatomic, assign) BOOL startMuted;

/// Indicates whether the requested video should have custom controls enabled for
/// play/pause/mute/unmute.
@property(nonatomic, assign) BOOL customControlsRequested;

/// Indicates whether the requested video should have the click to expand behavior.
@property(nonatomic, assign) BOOL clickToExpandRequested;

@end
