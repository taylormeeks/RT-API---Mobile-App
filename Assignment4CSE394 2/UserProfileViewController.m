//
//  UserProfileViewController.m
//  Assignment4CSE394
//
//  Created by James Perry on 3/31/15.
//  Copyright (c) 2015 James Perry. All rights reserved.
//

#import "UserProfileViewController.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
    [mediaTypes addObject:@"kUTTypeImage"];
    self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.mediaTypes = mediaTypes;
    self.allowsEditing = YES;
    
     USER PROFILE STUFF
     
     NSData *imageData = UIImagePNGRepresentation(image);
     PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
     [imageFile saveInBackground];
     
     PFUser *user = [PFUser currentUser];
     [user setObject:imageFile forKey:@"picture"];
     [user saveInBackground];
     */
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    // Displays saved pictures and movies, if both are available, from the
    // Camera Roll album.
    mediaUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = NO;
    
    mediaUI.delegate = delegate;
    
    [controller presentModalViewController: mediaUI animated: YES];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
