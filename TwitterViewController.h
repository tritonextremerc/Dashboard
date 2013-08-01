//
//  TwitterViewController.h
//  Dashboard
//
//  Created by Ray  on 7/31/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "TwitterView.h"
#import "TwitterViewCell.h"

@interface TwitterViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
{
    //UIPopoverController *popover;
    UILongPressGestureRecognizer *longPressRecognizer;
    UIPanGestureRecognizer *panRecognizer;
    UIPinchGestureRecognizer *pinchRecognizer;
    
    CGFloat mCurrentScale;
    CGFloat mLastScale;
}

@property (strong, nonatomic) NSArray *dataSource;

- (void)addGestureRecognizers;
- (void)removeGestureRecognizers;
- (void)editTwitterView;
- (void)activateTwitterView;

@end
