//
//  FlickrAPI.h
//  2w4d2_catMap
//
//  Created by Seantastic31 on 18/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"
#import "PhotoCollectionViewCell.h"

@interface FlickrAPI : NSObject

+ (void)getData:(void (^)(NSMutableArray *tmpArray))complete;

@end
