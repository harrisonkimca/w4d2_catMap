//
//  Photo.m
//  2w4d2_catMap
//
//  Created by Seantastic31 on 18/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithName:(NSString *)name Photo:(UIImage *)photo
{
    self = [super init];
    if (self) {
        _name = name;
        _photo = photo;
    }
    return self;
}

@end
