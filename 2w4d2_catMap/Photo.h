//
//  Photo.h
//  2w4d2_catMap
//
//  Created by Seantastic31 on 18/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

@import UIKit;
@import MapKit;

@interface Photo : NSObject

@property (strong, nonatomic) NSString *imageTitle;
@property (strong, nonatomic) UIImage *photo;
@property (strong, nonatomic) NSURL *urlImage;
@property (strong, nonatomic) NSURL *urlLocator;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;

- (instancetype)initWithTitle:(NSString*)title andURLImage:(NSURL*)urlImage andURLLocator:(NSURL*)urlLocator;

@end
