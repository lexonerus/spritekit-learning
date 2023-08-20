/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADNativeAdImage.h
//  Google Mobile Ads SDK
//
//  Copyright 2015 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// Native ad image.
@interface GADNativeAdImage : NSObject

/// The image. If image autoloading is disabled, this property will be nil.
@property(nonatomic, readonly, strong, nullable) UIImage *image;

/// The image's URL.
@property(nonatomic, readonly, copy, nullable) NSURL *imageURL;

/// The image's scale.
@property(nonatomic, readonly, assign) CGFloat scale;

@end
