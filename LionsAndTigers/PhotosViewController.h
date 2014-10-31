//
//  PhotosViewController.h
//  LionsAndTigers
//
//  Created by Andrew Liu on 10/30/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopDelegate  <NSObject>

- (void)topRevealButtonTapped;

@end

@interface PhotosViewController : UIViewController

@property (nonatomic, weak) id <TopDelegate> delegate;

@end
