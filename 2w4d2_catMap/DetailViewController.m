//
//  DetailViewController.m
//  2w4d2_catMap
//
//  Created by Seantastic31 on 18/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

#import "DetailViewController.h"
#import "Photo.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label.text = self.photo.imageTitle;
    
    // ***** convert url to image *****
    NSData *data = [NSData dataWithContentsOfURL:self.photo.urlImage];
    UIImage *image = [UIImage imageWithData:data];
    self.imageView.image = image;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask *dataTask = [session dataTaskWithRequest:[[NSURLRequest alloc]initWithURL:self.photo.urlLocator]
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
            NSDictionary *photoDictionary = [jsonDictionary valueForKey:@"photo"];
            NSDictionary *locationDictionary = [photoDictionary valueForKey:@"location"];
            NSString *latitudeString = [locationDictionary valueForKey:@"latitude"];
            NSString *longitudeString = [locationDictionary valueForKey:@"longitude"];
            float latitude = latitudeString.floatValue;
            float longitude = longitudeString.floatValue;
            self.photo.latitude = latitude;
            self.photo.longitude = longitude;
            
            NSLog(@"latitude: %f & longitude: %f", latitude, longitude);
            
        }];
    
    [dataTask resume];
}
@end
