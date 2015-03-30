//
//  Book.h
//  Assignment4CSE394
//
//  Created by James Perry on 2/26/15.
//  Copyright (c) 2015 James Perry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject <NSCoding>

@property NSDictionary *movieData;

@property NSURL *movieImage;
@property NSURL *movieAmazonLink;
@property NSString *movieTitle;
@property NSString *movieAuthor;
@property NSString *movieDescription;
@property NSString * movieRating;
@property NSString* movieYear;
@property NSString *movieType;

@end
