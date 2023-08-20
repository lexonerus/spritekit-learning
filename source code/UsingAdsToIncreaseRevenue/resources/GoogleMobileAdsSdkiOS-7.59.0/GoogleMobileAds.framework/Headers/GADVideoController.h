/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADVideoController.h
//  Google Mobile Ads SDK
//
//  Copyright 2016 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAdsDefines.h>
#import <UIKit/UIKit.h>

@protocol GADVideoControllerDelegate;

/// The video controller class provides a way to get the video metadata and also manages video
/// content of the ad rendered by the Google Mobile Ads SDK. You don't need to create an instance of
/// this class. When the ad rendered by the Google Mobile Ads SDK loads video content, you may be
/// able to get an instance of this class from the rendered ad object.
@interface GADVideoController : NSObject

/// Delegate for receiving video notifications.
@property(nonatomic, weak, nullable) id<GADVideoControllerDelegate> delegate;

/// Mute or unmute video. Set to YES to mute the video. Set to NO to allow the video to play sound.
- (void)setMute:(BOOL)mute;

/// Play the video. Doesn't do anything if the video is already playing.
- (void)play;

/// Pause the video. Doesn't do anything if the video is already paused.
- (void)pause;

/// Stops the video and displays the video's first frame. Call -play to resume playback at the start
/// of the video. Contact your account manager to enable this feature.
- (void)stop;

/// Indicates whether video custom controls (i.e. play/pause/mute/unmute) are enabled.
- (BOOL)customControlsEnabled;

/// Indicates whether video click to expand behavior is enabled.
- (BOOL)clickToExpandEnabled;

#pragma mark - Deprecated

/// Returns a Boolean indicating if the receiver has video content.
- (BOOL)hasVideoContent GAD_DEPRECATED_MSG_ATTRIBUTE(
    "Use the hasVideoContent property from GADUnifiedNativeAd's mediaContent instead.");

/// Returns the video's aspect ratio (width/height) or 0 if no video is present.
- (double)aspectRatio GAD_DEPRECATED_MSG_ATTRIBUTE(
    "Use the aspectRatio property from GADUnifiedNativeAd's mediaContent instead.");

@end
