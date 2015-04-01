//
//  ReadingListTableViewController.m
//  Assignment4CSE394
//
//  Created by James Perry on 3/1/15.
//  Copyright (c) 2015 James Perry. All rights reserved.
//

#import "ReadingListTableViewController.h"


@interface ReadingListTableViewController ()
@property Movie *selectedMovie;
@end

@implementation ReadingListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return self.tableMovieArray.count; //cant figure out how to make this work otherwise it always inits to 0
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookInfo" forIndexPath:indexPath];
    WatchedList *movie = self.tableMovieArray[indexPath.row];
    NSString *displayString = @"";
    displayString = [displayString stringByAppendingFormat:@"%@\n%@",movie.movieTitle,movie.movieAuthor];
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
    dest.showAdd = false;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
