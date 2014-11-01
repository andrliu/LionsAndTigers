//
//  PhotosViewController.m
//  LionsAndTigers
//
//  Created by Andrew Liu on 10/30/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

#import "PhotosViewController.h"
#import "CustomCollectionViewCell.h"

@interface PhotosViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation PhotosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.currentPhotosArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customCell"
                                                                               forIndexPath:indexPath];
    cell.customImageView.image = self.currentPhotosArray[indexPath.row];
    return cell;
}


- (IBAction)MenuButtonOnPressed:(UIBarButtonItem *)sender
{
    [self.delegate topRevealButtonTapped];
}


@end
