//
//  BookInfoViewController.h
//  Assignment4CSE394
//
//  Created by James Perry on 2/27/15.
//  Copyright (c) 2015 James Perry. All rights reserved.
//

#import "ViewController.h"
#import "ImageCache.h"
@interface BookInfoViewController : UIViewController
@property Movie* selectedMovie;
@property int showAdd;//0 = show, 1 = hide, 2 = remove
@property NSMutableArray *watchedMovies;
@property NSString *backedMovie;
@end
