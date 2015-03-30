//
//  ReadingListTableViewController.h
//  Assignment4CSE394
//
//  Created by James Perry on 3/1/15.
//  Copyright (c) 2015 James Perry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WatchedList.h"
#import "ImageCache.h"
#import "BookInfoViewController.h"
@interface ReadingListTableViewController : UITableViewController <UITableViewDataSource,     UITableViewDelegate>
@property NSMutableArray *tableMovieArray;
@end
