//
//  ReadingList.h
//  Assignment4CSE394
//
//  Created by James Perry on 3/1/15.
//  Copyright (c) 2015 James Perry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WatchedList : NSObject
@property NSURL *movieImage;
@property NSURL *movieAmazonLink;
@property NSString *movieTitle;
@property NSString *movieAuthor;
@property NSString *movieDescription;
@property NSString * movieRating;
@property NSString* movieYear;
@property NSString *movieType;
@property NSString *movieID;
@end
