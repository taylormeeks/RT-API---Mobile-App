//
//  BookInfoViewController.m
//  Assignment4CSE394
//
//  Created by James Perry on 2/27/15.
//  Copyright (c) 2015 James Perry. All rights reserved.
//

#import "BookInfoViewController.h"

@interface BookInfoViewController ()
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *MultiLineTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ImageField;
@property (strong, nonatomic) IBOutlet UIButton *RemoveFromListButton;
@property (strong, nonatomic) IBOutlet UILabel *DescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *RankLabel;
@property (strong, nonatomic) IBOutlet UILabel *WeekLabel;
@property (strong, nonatomic) IBOutlet UIButton *AddToReadListButton;
@property (strong, nonatomic) IBOutlet UILabel *AddToListLabel;
@property NSString *imageString;
@property NSString *amazonString;
@end

@implementation BookInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.showAdd == 0){
        self.RemoveFromListButton.hidden = true;
    }
    else if(self.showAdd == 1){ //1 = hide
        self.AddToReadListButton.hidden = true;
        self.AddToListLabel.hidden = true;
        self.RemoveFromListButton.hidden = false;
    }
    [self.AddToReadListButton addTarget: self action:@selector(addToReadListClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _imageString = [self.selectedMovie.movieImage absoluteString];
    self.ImageField.image = [[ImageCache sharedInstance] imageForKey:_imageString]; //retrieve cached image
    
    if(self.selectedMovie.movieTitle.length > 31){
        self.MultiLineTitleLabel.hidden = false;
        self.TitleLabel.hidden = true;
        self.MultiLineTitleLabel.text = self.selectedMovie.movieTitle;
    }
    else{
        self.MultiLineTitleLabel.hidden = true;
        self.TitleLabel.text = self.selectedMovie.movieTitle;
    }
    [self.TitleLabel sizeToFit];
    
    NSString * rankString = @"";
    rankString = [rankString stringByAppendingFormat:@"Rating: %@",self.selectedMovie.movieRating];
    self.RankLabel.text = rankString;
    
    NSString * weekString = @"";
    weekString = [weekString stringByAppendingFormat:@"Year: %@", self.selectedMovie.movieYear];
    self.WeekLabel.text = weekString;
    
    self.DescriptionLabel.text= self.selectedMovie.movieDescription;
    if ([self.selectedMovie.movieDescription length] < 1){
        self.DescriptionLabel.text = @"No Description Available";
    }

    [self.RemoveFromListButton addTarget: self action:@selector(removeTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    //self.AmazonLink.text = self.selectedMovie.bookAmazonLink;
    // Do any additional setup after loading the view.
}

-(void)addToReadListClicked:(id)sender
{
    
    PFObject *player = [PFObject objectWithClassName:@"Movie"];
    [player setObject:self.selectedMovie.movieTitle forKey:@"movieTitle"];
    [player setObject:_imageString forKey:@"movieImage"];
    [player setObject:self.selectedMovie.movieRating forKey:@"movieRating"];
    [player setObject:self.selectedMovie.movieDescription forKey:@"movieDescription"];
    [player setObject:self.selectedMovie.movieYear forKey:@"movieYear"];
    [player setObject:self.selectedMovie.movieAuthor forKey:@"movieAuthor"];
    //[player setObject:_amazonString forKey:@"movieAmazon"];
    [player setObject:[[PFUser currentUser] username] forKey:@"user"];
    [player save];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)removeTapped:(id)sender
{
    PFObject *object = [PFObject objectWithoutDataWithClassName:@"Movie"
                                                       objectId:self.selectedMovie.movieID];
    [object deleteEventually];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].

    
}


@end
