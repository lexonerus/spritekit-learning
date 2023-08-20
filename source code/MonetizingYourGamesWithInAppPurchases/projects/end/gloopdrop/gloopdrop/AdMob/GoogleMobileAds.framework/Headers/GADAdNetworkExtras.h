/***
 * Excerpted from "Apple Game Frameworks and Technologies",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tcswift for more book information.
***/
//
//  GADAdNetworkExtras.h
//  Google Mobile Ads SDK
//
//  Copyright 2012 Google LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/// An object implementing this protocol contains information set by the publisher on the client
/// device for a particular ad network.
///
/// Ad networks should create an 'extras' object implementing this protocol for their publishers to
/// use.
@protocol GADAdNetworkExtras <NSObject>
@end
