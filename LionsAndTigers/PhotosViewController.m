//
//  PhotosViewController.m
//  LionsAndTigers
//
//  Created by Andrew Liu on 10/30/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

#import "PhotosViewController.h"

@interface PhotosViewController ()

@end

@implementation PhotosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)MenuButtonOnPressed:(UIBarButtonItem *)sender
{
    [self.delegate topRevealButtonTapped];
}


@end
