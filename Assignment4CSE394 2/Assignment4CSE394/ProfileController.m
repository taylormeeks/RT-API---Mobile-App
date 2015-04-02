//
//  ProfileController.m
//  Assignment4CSE394
//
//  Created by Parker Derks on 4/1/15.
//  Copyright (c) 2015 James Perry. All rights reserved.
//

#import "ProfileController.h"

@interface ProfileController ()

@end

@implementation ProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameField.text = self.nameLabel.text;
    self.favMovieField.text = self.favMovieLabel.text;
    self.homeField.text = self.homeLabel.text;
    self.nameField.hidden = YES;
    self.favMovieField.hidden = YES;
    self.homeField.hidden = YES;
    self.saveButton.hidden = YES;
    self.bioText.editable = NO;
    
    self.watchedMovies = [[self.watchedMovies reverseObjectEnumerator] allObjects];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    //sets recently watched movie images and titles
    if([self.watchedMovies count] > 0)
    {
        [[ImageCache sharedInstance] downloadImageAtURL:[self.watchedMovies[0] movieImage] completionHandler:^(UIImage *image) {
            self.movie1Image.image = image;
        }];
        self.movie1Label.text = [self.watchedMovies[0] movieTitle];
    }
    if([self.watchedMovies count] > 1)
    {
        [[ImageCache sharedInstance] downloadImageAtURL:[self.watchedMovies[1] movieImage] completionHandler:^(UIImage *image) {
            self.movie2Image.image = image;
        }];
        self.movie2Label.text = [self.watchedMovies[1] movieTitle];
    }
    if([self.watchedMovies count] > 2)
    {
        [[ImageCache sharedInstance] downloadImageAtURL:[self.watchedMovies[2] movieImage] completionHandler:^(UIImage *image) {
            self.movie3Image.image = image;
        }];
        self.movie3Label.text = [self.watchedMovies[2] movieTitle];
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)getPic:(id)sender
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if((UIButton *) sender == self.chooseButton)
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    else
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            //only presents camera if available otherwise shows Photo Library
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.imageView.image = (UIImage*) [info objectForKey:UIImagePickerControllerOriginalImage];
}

- (IBAction)editProfile:(id)sender
{
    self.saveButton.hidden = NO;
    self.editButton.hidden = YES;
    self.nameLabel.hidden = YES;
    self.favMovieLabel.hidden = YES;
    self.homeLabel.hidden = YES;
    self.nameField.hidden = NO;
    self.favMovieField.hidden = NO;
    self.homeField.hidden = NO;
    self.bioText.editable = YES;
}

- (IBAction)saveProfile:(id)sender
{
    self.nameLabel.text = self.nameField.text;
    self.favMovieLabel.text = self.favMovieField.text;
    self.homeLabel.text = self.homeField.text;
    
    self.saveButton.hidden = YES;
    self.editButton.hidden = NO;
    self.nameLabel.hidden = NO;
    self.favMovieLabel.hidden = NO;
    self.homeLabel.hidden = NO;
    self.nameField.hidden = YES;
    self.favMovieField.hidden = YES;
    self.homeField.hidden = YES;
    self.bioText.editable = NO;
}
@end
