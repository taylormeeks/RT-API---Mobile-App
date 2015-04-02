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

@property (nonatomic) NSURL *movieImage;
@property (nonatomic) NSURL *movieAmazonLink;
@property (nonatomic) NSString *movieTitle;
@property (nonatomic) NSString *movieAuthor;
@property (nonatomic) NSString *movieDescription;
@property (nonatomic) NSString * movieRating;
@property (nonatomic) NSString* movieYear;
@property (nonatomic) NSString *movieType;
@property (nonatomic) NSString *movieID;

@end
