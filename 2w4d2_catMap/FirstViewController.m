//
//  FirstViewController.m
//  2w4d2_catMap
//
//  Created by Seantastic31 on 18/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

#import "FirstViewController.h"
#import "Photo.h"
#import "PhotoCollectionViewCell.h"
#import "DetailViewController.h"

@interface FirstViewController ()<UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray <Photo*>*photos;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    
    [self createData];
}

- (void)createData
{
    Photo *photo1 = [[Photo alloc]initWithName:@"Chicago" Photo:[UIImage imageNamed:@"chicago"]];
    
    self.photos = @[photo1];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    Photo *photo = self.photos [indexPath.row];
    
    cell.label.text = photo.name;
    cell.imageView.image = photo.photo;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailViewController"])
    {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        Photo *photo = self.photos[indexPath.row];
        DetailViewController *dvc = segue.destinationViewController;
        dvc.photo = photo;
    }
}

@end
