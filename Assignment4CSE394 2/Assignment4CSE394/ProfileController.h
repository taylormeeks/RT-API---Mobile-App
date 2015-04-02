//
//  ProfileController.h
//  Assignment4CSE394
//
//  Created by Parker Derks on 4/1/15.
//  Copyright (c) 2015 James Perry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
#import "Movie.h"
#import <ParseUI/ParseUI.h>
#import "WatchedList.h"
#import "ImageCache.h"
#import "User.h"

@interface ProfileController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property NSArray *watchedMovies;
@property User *thisUser;

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIButton *chooseButton;
@property (strong, nonatomic) IBOutlet UIButton *cameraButton;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *favMovieLabel;
@property (strong, nonatomic) IBOutlet UILabel *homeLabel;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *favMovieField;
@property (strong, nonatomic) IBOutlet UITextField *homeField;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UITextView *bioText;

@property (strong, nonatomic) IBOutlet UILabel *movie1Label;
@property (strong, nonatomic) IBOutlet UILabel *movie2Label;
@property (strong, nonatomic) IBOutlet UILabel *movie3Label;
@property (strong, nonatomic) IBOutlet UIImageView *movie1Image;
@property (strong, nonatomic) IBOutlet UIImageView *movie2Image;
@property (strong, nonatomic) IBOutlet UIImageView *movie3Image;



- (IBAction)getPic:(id)sender;
- (IBAction)editProfile:(id)sender;
- (IBAction)saveProfile:(id)sender;


@end
