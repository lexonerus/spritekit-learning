/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADServerSideVerificationOptions.h
//  Google Mobile Ads SDK
//
//  Copyright 2018 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Options for server-side verification callbacks for a rewarded ad.
@interface GADServerSideVerificationOptions : NSObject <NSCopying>

/// A unique identifier used to identify the user when making server-side verification reward
/// callbacks. This value will be passed as a parameter of the callback URL to the publisher's
/// server.
@property(nonatomic, copy, nullable) NSString *userIdentifier;

/// Optional custom reward string to include in the server-side verification callback.
@property(nonatomic, copy, nullable) NSString *customRewardString;

@end
