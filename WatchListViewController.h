//
//  WatchListViewController.h
//  Dashboard
//
//  Created by Ray  on 7/22/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "WatchListView.h"


@interface WatchListViewController : UITableViewController<UIGestureRecognizerDelegate>
{
    WatchListView *watchList;
    UIPopoverController *popover;
    UILongPressGestureRecognizer *longPressRecognizer;
    UIPanGestureRecognizer *panRecognizer;
    UIPinchGestureRecognizer *pinchRecognizer;
    
    CGFloat mCurrentScale;
    CGFloat mLastScale;
}

@end
