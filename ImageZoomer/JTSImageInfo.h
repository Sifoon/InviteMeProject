//
//  JTSImageInfo.h
//
//
//  Created by Jared Sinclair on 3/2/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

@import Foundation;
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface JTSImageInfo : NSObject

@property (strong, nonatomic) UIImage *image; // If nil, be sure to set either imageURL or canonicalImageURL.
@property (strong, nonatomic) UIImage *placeholderImage; // Use this if all you have is a thumbnail and an imageURL.
@property (copy, nonatomic) NSURL *imageURL;
@property (copy, nonatomic) NSURL *canonicalImageURL; // since `imageURL` might be a filesystem URL from the local cache.
@property (copy, nonatomic) NSString *altText;
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) CGRect referenceRect;
@property (strong, nonatomic) UIView *referenceView;
@property (assign, nonatomic) UIViewContentMode referenceContentMode;
@property (assign, nonatomic) CGFloat referenceCornerRadius;
@property (copy, nonatomic) NSMutableDictionary *userInfo;

- (NSString *)displayableTitleAltTextSummary;
- (NSString *)combinedTitleAndAltText;
- (CGPoint)referenceRectCenter;

@end

// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net 
