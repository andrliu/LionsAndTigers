//
//  RootViewController.m
//  LionsAndTigers
//
//  Created by Andrew Liu on 10/30/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

#import "RootViewController.h"
#import "PhotosViewController.h"

@interface RootViewController () <TopDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraintsOnPhotoView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraintsOnPhotoView;


@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINavigationController *naviController = self.childViewControllers[1];
    PhotosViewController *photoController = naviController.childViewControllers[0];
    photoController.delegate = self;
}



- (void)topRevealButtonTapped
{
    self.rightConstraintsOnPhotoView.constant = 30;
    self.leftConstraintsOnPhotoView.constant = 30;

}

@end
