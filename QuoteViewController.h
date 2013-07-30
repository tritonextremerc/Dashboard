//
//  QuoteViewController.h
//  Dashboard
//
//  Created by Ray  on 7/19/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "QuoteView.h"

@interface QuoteViewController : UIViewController<UIGestureRecognizerDelegate>
{
    QuoteView *view;
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
