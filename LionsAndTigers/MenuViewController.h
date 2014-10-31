//
//  MenuViewController.h
//  LionsAndTigers
//
//  Created by Andrew Liu on 10/30/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HUDDelegate  <NSObject>

@end

@interface MenuViewController : UIViewController

@property (nonatomic, weak) id <HUDDelegate> delegate;

@end
