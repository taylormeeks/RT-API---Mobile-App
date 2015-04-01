//
//  ProfileController.h
//  Assignment4CSE394
//
//  Created by Parker Derks on 4/1/15.
//  Copyright (c) 2015 James Perry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIButton *chooseButton;

- (IBAction)getPic:(id)sender;



@end
