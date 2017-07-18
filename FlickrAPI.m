//
//  FlickrAPI.m
//  2w4d2_catMap
//
//  Created by Seantastic31 on 18/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

#import "FlickrAPI.h"
#import "Key.h"
#import "Photo.h"

@interface FlickrAPI();

@end

@implementation FlickrAPI


// http://fuckingblocksyntax.com/
// use completion block to return array of results
+ (void)getData:(void (^)(NSMutableArray *tmpArray))complete
{
    // make http request for json
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=%@&tags=cat&has_geo=1", FLICKR_APIKEY]];
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionTask *dataTask = [session dataTaskWithRequest:urlRequest
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (error)
    {
        NSLog(@"error: %@", error.localizedDescription);
        return;
    }
                                      
        NSError *jsonError = nil;
        NSDictionary *jsonDictionary = [NSJSONSerialization
                                        JSONObjectWithData:data
                                        options:0
                                        error:&jsonError];
        
        if (jsonError)
        {
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
                                      
        // parse json file & add to array
        NSMutableArray *resultsArray = [@[] mutableCopy];
                                      
        NSDictionary *photosDictionary = [jsonDictionary valueForKey:@"photos"];
        NSArray *photoArray = [photosDictionary valueForKey:@"photo"];
        for (NSDictionary *myPhoto in photoArray)
        {
            NSString *myFarm = [myPhoto valueForKey:@"farm"];
            NSString *myServer = [myPhoto valueForKey:@"server"];
            NSString *myID = [myPhoto valueForKey:@"id"];
            NSString *mySecret = [myPhoto valueForKey:@"secret"];
                                          
            NSString *myTitle = [myPhoto valueForKey:@"title"];
            
            //image URL
            NSString *urlImageString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", myFarm, myServer, myID, mySecret];
            //NSLog(@"urlImage: %@", urlImageString);
            
            //locator URL
            NSString *urlLocatorString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&format=json&nojsoncallback=1&api_key=%@&photo_id=%@", FLICKR_APIKEY, myID];
            NSLog(@"urlLocator: %@", urlLocatorString);
            
            
            Photo *photo = [[Photo alloc]initWithTitle:myTitle andURLImage:[NSURL URLWithString:urlImageString] andURLLocator:[NSURL URLWithString:urlLocatorString]];
            //NSLog(@"%@, %@, %@, %@", myPhoto, photo.imageTitle, photo.urlImage, photo.urlLocator);
            [resultsArray addObject:photo];
        }
        complete(resultsArray);
    }];
    
    [dataTask resume];
}

@end
