/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADDebugOptionsViewController.h
//  Google Mobile Ads SDK
//
//  Copyright 2016 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GADDebugOptionsViewController;

/// Delegate for the GADDebugOptionsViewController.
@protocol GADDebugOptionsViewControllerDelegate <NSObject>

/// Called when the debug options flow is finished.
- (void)debugOptionsViewControllerDidDismiss:(nonnull GADDebugOptionsViewController *)controller;

@end

/// Displays debug options to the user.
@interface GADDebugOptionsViewController : UIViewController

/// Creates and returns a GADDebugOptionsViewController object initialized with the ad unit ID.
/// @param adUnitID An ad unit ID for the Google Ad Manager account that is being configured with
/// debug options.
+ (nonnull instancetype)debugOptionsViewControllerWithAdUnitID:(nonnull NSString *)adUnitID;

/// Delegate for the debug options view controller.
@property(nonatomic, weak, nullable) IBOutlet id<GADDebugOptionsViewControllerDelegate> delegate;

@end
