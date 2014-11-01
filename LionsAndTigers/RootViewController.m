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

@interface RootViewController () <TopDelegate, HUDDelegate, UICollisionBehaviorDelegate>

@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UIDynamicItemBehavior *dynamicItemBehavior;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) UIPushBehavior *pushBehavior;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraintsOnPhotoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraintsOnPhotoView;
@property NSMutableArray *lionsArray;
@property NSMutableArray *tigersArray;
@property UINavigationController *naviController;
@property PhotosViewController *photoController;
@property MenuViewController *menuController;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.naviController = self.childViewControllers[1];
    self.photoController = self.naviController.childViewControllers[0];
    self.photoController.delegate = self;

    self.menuController = self.childViewControllers[0];
    self.menuController.delegate = self;

    self.lionsArray = [@[[UIImage imageNamed:@"lion_1"],
                         [UIImage imageNamed:@"lion_2"],
                         [UIImage imageNamed:@"lion_3"],]mutableCopy];
    self.tigersArray = [@[[UIImage imageNamed:@"tiger_1"],
                          [UIImage imageNamed:@"tiger_2"],
                          [UIImage imageNamed:@"tiger_3"],]mutableCopy];

    self.photoController.currentPhotosArray = [NSMutableArray arrayWithArray:[self.lionsArray arrayByAddingObjectsFromArray:self.tigersArray]];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    self.collisionBehavior = [[UICollisionBehavior alloc]initWithItems:@[self.naviController.view]];

    self.collisionBehavior.collisionDelegate = self;

    self.gravityBehavior = [[UIGravityBehavior alloc]initWithItems:@[self.naviController.view]];

    self.dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.naviController.view]];

    self.pushBehavior = [[UIPushBehavior alloc]initWithItems:@[self.naviController.view]
                                                        mode:UIPushBehaviorModeContinuous];

    [self.collisionBehavior addBoundaryWithIdentifier:@"right"
                                            fromPoint:CGPointMake(self.view.frame.size.width + 76,
                                                                  -10)
                                              toPoint:CGPointMake(self.view.frame.size.width +76,
                                                                  self.view.frame.size.height + 10)];
    [self.collisionBehavior addBoundaryWithIdentifier:@"left"
                                            fromPoint:CGPointMake(0,
                                                                  -10)
                                              toPoint:CGPointMake(0,
                                                                  self.view.frame.size.height + 10)];

    [self.gravityBehavior setGravityDirection:CGVectorMake(0, 0)];

    [self.dynamicItemBehavior setElasticity:.1];

    [self.dynamicAnimator addBehavior:self.collisionBehavior];

    [self.dynamicAnimator addBehavior:self.gravityBehavior];

    [self.dynamicAnimator addBehavior:self.pushBehavior];

    [self.dynamicAnimator addBehavior:self.dynamicItemBehavior];

}

- (void)allButtonTapped;
{
    self.photoController.currentPhotosArray = [NSMutableArray arrayWithArray:[self.lionsArray arrayByAddingObjectsFromArray:self.tigersArray]];
    [self.photoController.photoCollectionView reloadData];
    [UIView animateWithDuration:kAnimationSpeed
                     animations:^{
                         self.leftConstraintsOnPhotoView.constant = -16;
                         self.rightConstraintsOnPhotoView.constant = -16;
                         [self.view layoutIfNeeded];
                                }
                     completion:nil];

}

- (void)lionsButtonTapped;
{
    self.photoController.currentPhotosArray = [NSMutableArray arrayWithArray:self.lionsArray];
    [self.photoController.photoCollectionView reloadData];
    [UIView animateWithDuration:kAnimationSpeed
                     animations:^{
                            self.leftConstraintsOnPhotoView.constant = -16;
                            self.rightConstraintsOnPhotoView.constant = -16;
                            [self.view layoutIfNeeded];
                                }
                     completion:nil];

}

- (void)tigersButtonTapped;
{
    self.photoController.currentPhotosArray = [NSMutableArray arrayWithArray:self.tigersArray];
    [self.photoController.photoCollectionView reloadData];
    [UIView animateWithDuration:kAnimationSpeed
                     animations:^{
                         self.leftConstraintsOnPhotoView.constant = -16;
                         self.rightConstraintsOnPhotoView.constant = -16;
                         [self.view layoutIfNeeded];
                                }
                     completion:nil];
}

- (void)topRevealButtonTapped
{

    if (self.leftConstraintsOnPhotoView.constant == -16)
    {
    [UIView animateWithDuration:kAnimationSpeed
                     animations:^{
                         self.leftConstraintsOnPhotoView.constant = 60;
                         self.rightConstraintsOnPhotoView.constant = -92;
                         [self.view layoutIfNeeded];
                                }
                     completion:nil];
    }
    else
    {
        [UIView animateWithDuration:kAnimationSpeed
                         animations:^{
                             self.leftConstraintsOnPhotoView.constant = -16;
                             self.rightConstraintsOnPhotoView.constant = -16;
                             [self.view layoutIfNeeded];
                                    }
                         completion:nil];
    }

}

- (IBAction)panHandler:(UIPanGestureRecognizer *)gesture
{
    CGPoint xtanslation = [gesture translationInView:gesture.view];
    self.leftConstraintsOnPhotoView.constant = self.leftConstraintsOnPhotoView.constant + xtanslation.x;
    self.rightConstraintsOnPhotoView.constant = self.rightConstraintsOnPhotoView.constant - xtanslation.x;
    [gesture setTranslation:CGPointMake(0, 0) inView:gesture.view];

    CGFloat xVelocity = [gesture velocityInView:gesture.view].x;
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        [self.dynamicAnimator updateItemUsingCurrentState:self.naviController.view];

        if (xVelocity < -500.0)
        {
            [self.gravityBehavior setGravityDirection:CGVectorMake(-1, 0)];
            [self.dynamicItemBehavior setElasticity:0.5];
            [self.pushBehavior setPushDirection:CGVectorMake([gesture velocityInView:gesture.view].x, 0)];
        }
        else if (xVelocity >= -500.0 && xVelocity < 0)
        {
            [self.gravityBehavior setGravityDirection:CGVectorMake(-1, 0)];
            [self.dynamicItemBehavior setElasticity:0.25];
            [self.pushBehavior setPushDirection:CGVectorMake(-500.0, 0.0)];
        }
        else if (xVelocity >= 0 && xVelocity < 500.0)
        {
            [self.gravityBehavior setGravityDirection:CGVectorMake(1, 0)];
            [self.dynamicItemBehavior setElasticity:0.25];
            [self.pushBehavior setPushDirection:CGVectorMake(500.0, 0.0)];
        }
        else
        {
            [self.gravityBehavior setGravityDirection:CGVectorMake(1, 0)];
            [self.dynamicItemBehavior setElasticity:0.5];
            [self.pushBehavior setPushDirection:CGVectorMake([gesture velocityInView:gesture.view].x, 0)];
        }
    }

}


@end
