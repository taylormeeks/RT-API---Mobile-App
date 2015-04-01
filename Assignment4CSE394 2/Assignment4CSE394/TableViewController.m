//
//  TableViewController.m
//  Assignment4CSE394
//
//  Created by James Perry on 2/26/15.
//  Copyright (c) 2015 James Perry. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
@property Movie *selectedMovie;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [tempImageView release];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.tableMovieArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookInfo" forIndexPath:indexPath];
    Movie *movie = self.tableMovieArray[indexPath.row];
    NSString *displayString = @"";
    displayString = [displayString stringByAppendingFormat:@"%@\n%@",movie.movieTitle,movie.movieRating];
    cell.textLabel.textColor =[UIColor whiteColor];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.text = displayString;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    // Configure the cell...
    if(movie.movieImage != nil){
        [[ImageCache sharedInstance] downloadImageAtURL:movie.movieImage completionHandler:^(UIImage *image) {
            cell.imageView.image = image;
            [cell setNeedsLayout];
        }];
    }
 
    UIImageView *av = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 277, 58)];
    av.backgroundColor = [UIColor clearColor];
    av.opaque = NO;
    av.image = [UIImage imageNamed:@"Film-Strip.jpg"];
    cell.backgroundView = av;
    
    self.selectedMovie = [[Movie alloc]init];
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    self.selectedMovie = self.tableMovieArray[indexPath.row];
    [self performSegueWithIdentifier:@"BookInfoClicked" sender:self];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BookInfoViewController *dest = segue.destinationViewController;
    dest.selectedMovie = self.selectedMovie;
    dest.showAdd = self.ShowAdd;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
