/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADNativeAdImage+Mediation.h
//  Google Mobile Ads SDK
//
//  Copyright 2015 Google. All rights reserved.
//

#import <GoogleMobileAds/GADNativeAdImage.h>

/// Provides additional GADNativeAdImage initializers.
@interface GADNativeAdImage (MediationAdditions)

/// Initializes and returns a native ad image object with the provided image.
- (nonnull instancetype)initWithImage:(nonnull UIImage *)image;

/// Initializes and returns a native ad image object with the provided image URL and image scale.
- (nonnull instancetype)initWithURL:(nonnull NSURL *)URL scale:(CGFloat)scale;

@end
