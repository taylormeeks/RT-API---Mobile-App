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
    self.selectedMovie = [[Movie alloc]init];
    
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
    /*dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger numBooks = self.tableBookList.count;
        if(indexPath.row == numBooks-5)
        {
            NSInteger newBooks = [self.manager requestMoreMovies];
            NSMutableArray *paths = [[NSMutableArray alloc] init];
            for(NSInteger i=numRecipes; i<numRecipes+newRecipes; i++)
            {
                [paths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableView beginUpdates];
                if(paths.count)
                    [tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationLeft];
                [tableView endUpdates];
                
            });
        }
    });*/

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
    dest.showAdd = true;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
