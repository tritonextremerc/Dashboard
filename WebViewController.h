//
//  WebViewController.h
//  Nerdfeed
//
//  Created by Ray  on 6/26/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface WebViewController : UIViewController<UIGestureRecognizerDelegate>
{
    UILongPressGestureRecognizer *longPressRecognizer;
    UIPanGestureRecognizer *panRecognizer;
    UIPinchGestureRecognizer *pinchRecognizer;
    
    CGFloat mCurrentScale;
    CGFloat mLastScale;
}

@property (nonatomic, readonly) UIWebView *webView;



@end
