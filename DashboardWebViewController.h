//
//  DashboardWebViewController.h
//  Dashboard
//
//  Created by Ray  on 7/15/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "WebView.h"

@interface DashboardWebViewController : UIViewController<UIGestureRecognizerDelegate>
{
    WebView *dashboardWebView;
    UIWebView *webView;
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
