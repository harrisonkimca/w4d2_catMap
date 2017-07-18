//
//  Photo.h
//  2w4d2_catMap
//
//  Created by Seantastic31 on 18/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

@import UIKit;

@interface Photo : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UIImage *photo;

- (instancetype)initWithName:(NSString*)name Photo:(UIImage*)photo;

@end
