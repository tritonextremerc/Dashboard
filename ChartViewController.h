//
//  RegularViewController.h
//  Dashboard
//
//  Created by Ray  on 7/12/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "ChartView.h"

@interface ChartViewController : UIViewController<UIGestureRecognizerDelegate>
{
    ChartView *view;
    UILongPressGestureRecognizer *longPressRecognizer;
    UIPanGestureRecognizer *panRecognizer;
    UITapGestureRecognizer *tapRecognizer;
    UIPinchGestureRecognizer *pinchRecognizer;
    
    CGRect defaultRect;
    
    CGFloat mCurrentScale;
    CGFloat mLastScale;
    
    CGFloat minScale;
    CGFloat maxScale;
    
}



@end
