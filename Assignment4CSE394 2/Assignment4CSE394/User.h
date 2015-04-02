//
//  User.h
//  Assignment4CSE394
//
//  Created by James Perry on 4/2/15.
//  Copyright (c) 2015 James Perry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface User : NSObject
@property (nonatomic, strong) NSString* bio;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* favMovie;
@property (nonatomic, strong) NSString* location;
@property (nonatomic) PFFile* picture;
@end
