//
//  Photo.m
//  2w4d2_catMap
//
//  Created by Seantastic31 on 18/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithTitle:(NSString *)title andURLImage:(NSURL *)urlImage andURLLocator:(NSURL *)urlLocator
{
    self = [super init];
    if (self) {
        _imageTitle = title;
        _urlImage = urlImage;
        _urlLocator = urlLocator;
        _latitude = 0;
        _longitude = 0;
    }
    return self;
}

@end
