//
//  RootViewController.m
//  LionsAndTigers
//
//  Created by Andrew Liu on 10/30/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

#import "RootViewController.h"
#import "PhotosViewController.h"
#import "MenuViewController.h"
#import "CustomCollectionViewCell.h"

#define kAnimationSpeed 0.6

@interface RootViewController () <TopDelegate,HUDDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraintsOnPhotoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraintsOnPhotoView;
@property NSMutableArray *lionsArray;
@property NSMutableArray *tigersArray;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINavigationController *naviController = self.childViewControllers[1];
    PhotosViewController *photoController = naviController.childViewControllers[0];
    photoController.delegate = self;

    MenuViewController *menuController = self.childViewControllers[0];
    menuController.delegate = self;

    self.lionsArray = [@[[UIImage imageNamed:@"lion_1"],
                         [UIImage imageNamed:@"lion_2"],
                         [UIImage imageNamed:@"lion_3"],]mutableCopy];
    self.tigersArray = [@[[UIImage imageNamed:@"tiger_1"],
                          [UIImage imageNamed:@"tiger_2"],
                          [UIImage imageNamed:@"tiger_3"],]mutableCopy];

    photoController.currentPhotosArray = [NSMutableArray arrayWithArray:[self.lionsArray arrayByAddingObjectsFromArray:self.tigersArray]];

}

- (void)allButtonTapped;
{
    UINavigationController *naviController = self.childViewControllers[1];
    PhotosViewController *photoController = naviController.childViewControllers[0];
    photoController.currentPhotosArray = [NSMutableArray arrayWithArray:[self.lionsArray arrayByAddingObjectsFromArray:self.tigersArray]];
    [photoController.photoCollectionView reloadData];
    [UIView animateWithDuration:kAnimationSpeed
                     animations:^{
                         self.leftConstraintsOnPhotoView.constant = -16;
                         [self.view layoutIfNeeded];
                     } completion:nil];

}

- (void)lionsButtonTapped;
{
    UINavigationController *naviController = self.childViewControllers[1];
    PhotosViewController *photoController = naviController.childViewControllers[0];
    photoController.currentPhotosArray = [NSMutableArray arrayWithArray:self.lionsArray];
    [photoController.photoCollectionView reloadData];
    [UIView animateWithDuration:kAnimationSpeed
                     animations:^{
                         self.leftConstraintsOnPhotoView.constant = -16;
                         [self.view layoutIfNeeded];
                     } completion:nil];

}

- (void)tigersButtonTapped;
{
    UINavigationController *naviController = self.childViewControllers[1];
    PhotosViewController *photoController = naviController.childViewControllers[0];
    photoController.currentPhotosArray = [NSMutableArray arrayWithArray:self.tigersArray];
    [photoController.photoCollectionView reloadData];
    [UIView animateWithDuration:kAnimationSpeed
                     animations:^{
                         self.leftConstraintsOnPhotoView.constant = -16;
                         [self.view layoutIfNeeded];
                     } completion:nil];
}

- (void)topRevealButtonTapped
{

    if (self.leftConstraintsOnPhotoView.constant == -16)
    {
    [UIView animateWithDuration:kAnimationSpeed
                     animations:^{
                         self.leftConstraintsOnPhotoView.constant = 50;
                         [self.view layoutIfNeeded];
                     } completion:nil];
    }
    else
    {
        [UIView animateWithDuration:kAnimationSpeed
                         animations:^{
                             self.leftConstraintsOnPhotoView.constant = -16;
                             [self.view layoutIfNeeded];
                         } completion:nil];
    }

}


@end
