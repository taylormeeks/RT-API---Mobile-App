//
//  ViewController.h
//  Assignment4CSE394
//
//  Created by James Perry on 2/25/15.
//  Copyright (c) 2015 James Perry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
#import "MovieManager.h"
#import "Movie.h"
#import "TableViewController.h"
#import <ParseUI/ParseUI.h>
#import "ReadingListTableViewController.h"

@interface ViewController : UIViewController <UIPickerViewDataSource>

@property MovieManager *manager;

@end

