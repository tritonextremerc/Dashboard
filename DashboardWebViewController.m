//
//  DashboardWebViewController.m
//  Dashboard
//
//  Created by Ray  on 7/15/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import "DashboardWebViewController.h"


@interface DashboardWebViewController ()

@end

@implementation DashboardWebViewController

- (void)loadView
{
    [super loadView];
    [self setView:[[WebView alloc] initWithFrame:CGRectMake(120, 40, 300, 300)]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    webView = [[UIWebView alloc] init];
    NSURL *urlQuery = [NSURL URLWithString:@"http://www.tdameritrade.com"];
    NSURLRequest *req = [NSURLRequest requestWithURL:urlQuery];
    [webView loadRequest:req];
    
    [webView setScalesPageToFit:YES];
    [dashboardWebView addSubview:webView];
    
    NSLog(@"View Loaded");
    
    
    
    panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPress:)];
    [panRecognizer setDelegate:self];
    [self.view addGestureRecognizer:panRecognizer];
    
    longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [longPressRecognizer setDelegate:self];
    [self.view addGestureRecognizer:longPressRecognizer];
    
    pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchPress:)];
    [pinchRecognizer setDelegate:self];
    [self.view addGestureRecognizer:pinchRecognizer];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [tapRecognizer setNumberOfTapsRequired:2];
    [tapRecognizer setDelegate:self];
    [self.view addGestureRecognizer:tapRecognizer];
    
    
    // Scale values for pinch Recognizer
    mCurrentScale = 0;
    mLastScale = 0;
    
    maxScale = 2.0;
    minScale = 1.0;
    
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
        
        return NO;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)panPress:(UIPanGestureRecognizer *)pr
{
    if ([pr state] == UIGestureRecognizerStateChanged){
        NSLog(@"Panning Began");
        
        [self.parentViewController.view bringSubviewToFront:self.view];
        
        // Get the XY touch point of view on screen
        CGPoint translation = [pr locationInView:self.view];
        
        // Padding to place finger in the center of the view
        CGPoint padding = CGPointMake(140, 140);
        
        translation.x -= padding.x;
        translation.y -= padding.y;
        
        pr.view.center = CGPointMake(pr.view.center.x + translation.x, pr.view.center.y + translation.y);
        
                
        
        
        [self.view setNeedsDisplay];
        
        
        [pr setTranslation:CGPointZero inView:self.view];
        
        
    }
}

- (void)longPress:(UIGestureRecognizer *)gr
{
    if ([gr state] == UIGestureRecognizerStateBegan){
        NSLog(@"Long Press Began");
        
        CGPoint point = [gr locationInView:self.view];
        
        [self becomeFirstResponder];
        //[longPressRecognizer setCancelsTouchesInView:YES];
        
        //Grab Menu Controller
        UIMenuController *menu = [UIMenuController sharedMenuController];
        
        // Create a new "Delete" UIMenuItem
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(delete:)];
        
        [menu setMenuItems:[NSArray arrayWithObject:deleteItem]];
        
        // Tell the menu where it should come from and show it
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self.view];
        [menu setMenuVisible:YES animated:YES];
        
    }
    
    [self.view setNeedsDisplay];
    
    
    
}

- (void)pinchPress:(UIPinchGestureRecognizer *)ppr
{
    NSLog(@"last scale = %f", mLastScale);
    
    if([ppr state] == UIGestureRecognizerStateBegan) {
        // Reset the last scale, necessary if there are multiple objects with different scales
        mLastScale = [ppr scale];
    }
    
    if ([ppr state] == UIGestureRecognizerStateBegan ||
        [ppr state] == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = [[[ppr view].layer valueForKeyPath:@"transform.scale"] floatValue];
        
        // Constants to adjust the max/min values of zoom
        const CGFloat kMaxScale = 2.0;
        const CGFloat kMinScale = 0.75;
        
        CGFloat newScale = 1 -  (mLastScale - [ppr scale]);
        newScale = MIN(newScale, kMaxScale / currentScale);
        newScale = MAX(newScale, kMinScale / currentScale);
        CGAffineTransform transform = CGAffineTransformScale([[ppr view] transform], newScale, newScale);
        [ppr view].transform = transform;
        
        mLastScale = [ppr scale];  // Store the previous scale factor for the next pinch gesture call
    }
    
    
}

- (void)tap:(UITapGestureRecognizer *)tr
{
    NSLog(@"Double tapped");
    //[self.parentViewController.view bringSubviewToFront:self.view];
    [self.view setNeedsDisplay];
}


- (void)delete:(id)sender
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
