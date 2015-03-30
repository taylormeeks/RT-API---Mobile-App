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
@property (strong, nonatomic) IBOutlet UILabel *AuthorLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ImageField;
@property (strong, nonatomic) IBOutlet UILabel *DescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *AmazonLink;
@property (strong, nonatomic) IBOutlet UILabel *RankLabel;
@property (strong, nonatomic) IBOutlet UILabel *WeekLabel;
@property (strong, nonatomic) IBOutlet UIButton *AddToReadListButton;
@property NSString *imageString;
@property NSString *amazonString;
@end

@implementation BookInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(!self.showAdd){
        self.AddToReadListButton.hidden = true;
    }
    [self.AddToReadListButton addTarget: self action:@selector(addToReadListClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.DescriptionLabel.numberOfLines = 5;
    self.TitleLabel.numberOfLines = 3;
    self.AuthorLabel.numberOfLines = 2;
    
    _imageString = [self.selectedMovie.movieImage absoluteString];
    self.ImageField.image = [[ImageCache sharedInstance] imageForKey:_imageString]; //retrieve cached image
    self.TitleLabel.text = self.selectedMovie.movieTitle;
    self.AuthorLabel.text = self.selectedMovie.movieAuthor;
    
    NSString * rankString = @"";
    rankString = [rankString stringByAppendingFormat:@"Rating: %@",self.selectedMovie.movieRating];
    self.RankLabel.text = rankString;
    
    NSString * weekString = @"";
    weekString = [weekString stringByAppendingFormat:@"Year: %@", self.selectedMovie.movieYear];
    self.WeekLabel.text = weekString;
    
    self.DescriptionLabel.text= self.selectedMovie.movieDescription;
    
    _amazonString = @"";
    _amazonString = [_amazonString stringByAppendingFormat:@"Buy: %@",[self.selectedMovie.movieAmazonLink absoluteString]];
    self.AmazonLink.text = _amazonString;
    
    //self.AmazonLink.text = self.selectedMovie.bookAmazonLink;
    // Do any additional setup after loading the view.
}

-(void)addToReadListClicked:(id)sender
{
    
    PFObject *player = [PFObject objectWithClassName:@"Book"];
    [player setObject:self.selectedMovie.movieTitle forKey:@"movieTitle"];
    [player setObject:_imageString forKey:@"movieImage"];
    [player setObject:self.selectedMovie.movieRating forKey:@"movieRating"];
    [player setObject:self.selectedMovie.movieDescription forKey:@"movieDescription"];
    [player setObject:self.selectedMovie.movieYear forKey:@"movieWeeks"];
    [player setObject:self.selectedMovie.movieAuthor forKey:@"movieAuthor"];
    [player setObject:_amazonString forKey:@"movieAmazon"];
    [player setObject:[[PFUser currentUser] username] forKey:@"user"];
    [player save];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
