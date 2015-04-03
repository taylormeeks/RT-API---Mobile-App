//
//  Book.m
//  Assignment4CSE394
//
//  Created by James Perry on 2/26/15.
//  Copyright (c) 2015 James Perry. All rights reserved.
//

#import "Movie.h"
#define DATA_KEY @"data"
@implementation Movie

-(NSString *)movieTitle
{
    return self.movieData[@"title"];
}
-(NSString *)movieAuthor
{
    return @"";
    //return self.movieData[@"abridged_cast"][@"name"];
}

-(NSString *)movieDescription
{
    return self.movieData[@"synopsis"];
}

-(NSString *)movieRuntime
{
    return self.movieData[@"runtime"];
}

-(NSString *)movieRating
{
    return self.movieData[@"mpaa_rating"];
}
-(NSString *)movieYear
{
    return self.movieData[@"year"];
}

-(NSURL *)movieAmazonLink
{
    return nil;
    //return [NSURL URLWithString:self.movieData[@"amazon_product_url"]];
}

-(NSURL *)movieImage
{
    return [NSURL URLWithString:self.movieData[@"posters"][@"thumbnail"]];
}
                         
#pragma mark - NSCoding

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.movieData = [aDecoder decodeObjectForKey:DATA_KEY];
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{        [
          aCoder encodeObject:self.movieData forKey:DATA_KEY];
}

- (BOOL)isEqual:(Movie*)other {
    if([other.movieTitle isEqual:self.movieTitle])
        return TRUE;
    else{
        return FALSE;
    }
}

@end
