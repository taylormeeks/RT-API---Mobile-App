//
//  ViewController.m
//  Assignment4CSE394
//
//  Created by James Perry on 2/25/15.
//  Copyright (c) 2015 James Perry. All rights reserved.
//  BestSelers API Key:  065415ec04c5c377808c199095f59ec4:17:71463407

#import "ViewController.h"
#import "Parse/Parse.h"

#define RT_API_KEY @"&apikey=tk8xcgeeg8ud35ha5j8dgpft";

#define RT_API_URL @"http://api.rottentomatoes.com/api/public/v1.0/movies.json?"

#define NYT_VALID_LIST_NAMES_URL @"http://api.nytimes.com/svc/books/v3/lists/names.json?api-key=065415ec04c5c377808c199095f59ec4:17:71463407"

#define RESPONSE_TYPE @".json?"

#define NYT_VALID_LIST_NAMES_URL @"http://api.nytimes.com/svc/books/v3/lists/names.json?api-key=065415ec04c5c377808c199095f59ec4:17:71463407"

@interface ViewController () 
@property (strong, nonatomic) IBOutlet UISearchBar *SearchBar;
@property (strong, nonatomic) IBOutlet UIButton *SearchButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *LogoutButton;
@property (strong, nonatomic) IBOutlet UIButton *ReadingListButton;
@property NSMutableArray *watchedMovies;
@end


@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[MovieManager alloc]init];
    self.manager.movieList =[[NSMutableArray alloc] init];
    NSString *requestType = NYT_VALID_LIST_NAMES_URL;
    NSURL *typeUrl = [NSURL URLWithString:requestType];
    NSData *typeData =[NSData dataWithContentsOfURL:typeUrl];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:typeData options:kNilOptions error:Nil];
    NSString *tempResult = dict[@"num_results"];
    self.manager.numOfTypes = tempResult.integerValue;
    
    NSArray *typeResults = [dict valueForKeyPath:@"results"];
    
    self.manager.movieTypeList =[[NSMutableArray alloc] init];
    for(NSDictionary *movie in typeResults)
    {
        Movie *ourMovie = [[Movie alloc] init];
        ourMovie.movieData = movie;
        [self.manager.movieTypeList addObject:ourMovie];
    }
    [self.SearchButton addTarget: self action:@selector(searchTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ReadingListButton addTarget: self action:@selector(readListTapped:) forControlEvents:UIControlEventTouchUpInside];
    //[self.LogoutButton addTarget: self action:@selector(logoutPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)viewWillAppear:(BOOL)animated{
    if(self.manager.movieList != nil){
        self.manager.movieList = nil;
        self.manager.movieList = [[NSMutableArray alloc]init];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self performLogin];
    if([[PFUser currentUser] username] != nil){
    [self loadBooksWithCompletionBlock];
    }
}



-(void)loadBooksWithCompletionBlock

{
    
    PFQuery *listQuery = [PFQuery queryWithClassName:@"Book"];
    self.watchedMovies = [NSMutableArray new];
    //limit to books to user
    [listQuery whereKey:@"user" equalTo:[[PFUser currentUser] username]];
    
    [listQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        for (PFObject *object in objects) {
            WatchedList *newMovie = [[WatchedList alloc]init];
            
            NSString *rewriteString = [object objectForKey:@"bookTitle"];
            newMovie.movieTitle = rewriteString;
            
            NSString *rewriteString2 = [object objectForKey:@"bookImage"];
            NSURL *url = [NSURL URLWithString:[rewriteString2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            newMovie.movieImage = url;
            
            NSString *rewriteString3 = [object objectForKey:@"bookRank"];
            newMovie.movieRating = rewriteString3;
            
            NSString *rewriteString4 = [object objectForKey:@"bookDescription"];
            newMovie.movieDescription = rewriteString4;
            
            NSString *rewriteString5 = [object objectForKey:@"bookWeeks"];
            newMovie.movieWeeks = rewriteString5;
            
            NSString *rewriteString6 = [object objectForKey:@"bookAuthor"];
            newMovie.movieAuthor = rewriteString6;
            
            NSString *rewriteString7 = [object objectForKey:@"bookAmazon"];
            NSURL *url2 = [NSURL URLWithString:[rewriteString7 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            newMovie.movieAmazonLink= url2;
            
            [self.watchedMovies addObject:newMovie];
            
        }
    }];
    
}

-(void)readListTapped:(id)sender
{
    [self performSegueWithIdentifier:@"readListClicked" sender:self.ReadingListButton];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self requestMovieswithTitle:self.SearchBar.text];
    
}

//get fields and make api call with values
-(void)searchTapped:(id)sender
{
    
    //self.manager.Title = self.TitleField.text;
    //self.manager.Author = self.AuthorField.text;
    //[self getTypeSelection]; //gets type and puts it in myType
    //[self requestBookswithType:self.manager.myType
}

- (void)requestMovieswithTitle:(NSString *)Title
{
    NSString* title = [Title stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *requestString = [NSString stringWithFormat:@"%@q=%@%@",RT_API_URL,title,@"&apikey=tk8xcgeeg8ud35ha5j8dgpft"];
    
    NSLog(@"%@",requestString);
    NSURL *url = [NSURL URLWithString:requestString];

    NSData *data =[NSData dataWithContentsOfURL:url];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:Nil];
    NSString *tempResult = dict[@"total"];
    self.manager.numberOfResults = tempResult.integerValue;
    NSDictionary *results = [dict valueForKeyPath:@"movies"];
    
   // NSArray *books = results[@"movies"];
    for(NSDictionary *movie in results)
    {
        Movie *ourMovie = [[Movie alloc] init];
        ourMovie.movieData = movie;
        [self.manager.movieList addObject:ourMovie];
    }

    [self performSegueWithIdentifier:@"searchWasClicked" sender:self.SearchButton];
    
}


#pragma mark - user authentication stuff

-(void)performLogin
{
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}

-(IBAction)logoutPressed:(id)sender
{
    [PFUser logOut];
    [self.navigationController popViewControllerAnimated:YES];
    
    [self performLogin];
}

#pragma mark - Parse Login delegation

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    //    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Parse sign up delegation

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   // NSLog(@"%@", );
    if(sender == self.SearchButton){
        TableViewController *dest = segue.destinationViewController;
        dest.tableMovieArray = self.manager.movieList;
    }
    else{
        ReadingListTableViewController *dest = segue.destinationViewController;
        dest.tableMovieArray = self.watchedMovies;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end