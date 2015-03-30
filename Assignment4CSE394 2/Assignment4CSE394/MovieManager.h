//
//  BookManager.h
//  Assignment4CSE394
//
//  Created by James Perry on 2/26/15.
//  Copyright (c) 2015 James Perry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

#import <Foundation/Foundation.h>
@interface MovieManager : NSObject

@property (nonatomic) NSMutableArray *movieList;
@property (nonatomic) NSMutableArray *movieTypeList;
@property (nonatomic) NSMutableArray *watchedList;

@property NSString *Title;
@property NSString *Author;
@property NSString *myType;
@property NSInteger numberOfResults;
@property NSInteger numOfTypes;

@end
