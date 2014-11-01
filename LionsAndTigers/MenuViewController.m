//
//  MenuViewController.m
//  LionsAndTigers
//
//  Created by Andrew Liu on 10/30/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (IBAction)allButtonTapped:(UIButton *)sender
{
    [self.delegate allButtonTapped];
}

- (IBAction)lionsButtonTapped:(UIButton *)sender
{
    [self.delegate lionsButtonTapped];
}

- (IBAction)tigersButtonTapped:(UIButton *)sender
{
    [self.delegate tigersButtonTapped];
}

@end
