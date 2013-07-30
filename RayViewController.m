//
//  RayViewController.m
//  Dashboard
//
//  Created by Ray  on 7/17/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import "RayViewController.h"

@interface RayViewController ()

@end

@implementation RayViewController

@synthesize quoteView;
@synthesize chartView;
@synthesize webView;
@synthesize watchListView;
@synthesize moviePlayer;

- (void)loadQuoteView
{
    [super loadView];
    
    defaultQuoteViewRect = CGRectMake(0, 380, 300, 300);
    quoteView = [[QuoteView alloc] initWithFrame:defaultQuoteViewRect];
    [self setView:quoteView];
    
    
    
}

- (void)loadChartView
{
    [super loadView];
    defaultChartViewRect = CGRectMake(0, 40, 300, 300);
    chartView = [[ChartView alloc] initWithFrame:defaultChartViewRect];
    [self setView:chartView];
    
    
}

- (void)loadWebView
{
    [super loadView];
    defaultWebViewRect = CGRectMake(640, 40, 300, 300);
    webView = [[WebView alloc] initWithFrame:defaultWebViewRect];
    [self setView:webView];
    
}

- (void)loadWatchListView
{
    [super loadView];
    defaultWatchListRect = CGRectMake(700, 50, 300, 600);
    watchListView = [[WatchListView alloc] initWithFrame:defaultWatchListRect];
    [self setView:watchListView];
    
}

- (void)loadMoviePlayer
{
    [super loadView];
    NSURL *movieURL = [NSURL URLWithString:@"http://mobile.insider.thomsonreuters.com/video/3/2013/07/22/1104628_mobile-400k_1374500201506.mp4"];
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    
    [moviePlayer.view setFrame:CGRectMake(640, 380, 300, 300)];
    
    
    
    moviePlayer.controlStyle = MPMovieControlStyleDefault;
    moviePlayer.shouldAutoplay = YES;
    
    [self.view addSubview:moviePlayer.view];
    [moviePlayer setFullscreen:NO];
    
    [self setView:moviePlayer.view];
    
    // Top toolbar
    UIToolbar *topBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    [topBar setTintColor:[UIColor blackColor]];
    
    // Bottom toolbar
    UIToolbar *bottomBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 300, 300, 20)];
    [bottomBar setTintColor:[UIColor blackColor]];
    
    [self.view addSubview:topBar];
    [self.view addSubview:bottomBar];
}


- (void)viewDidLoad
{
    NSLog(@"View Loaded");
    
    
}

- (void)addLongPressRecognizer
{
    longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [longPressRecognizer setDelegate:self];
    [self.view addGestureRecognizer:longPressRecognizer];
}

- (void)addPanRecognizer
{
    panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPress:)];
    [panRecognizer setDelegate:self];
    [self.view addGestureRecognizer:panRecognizer];
    
}

- (void)addPinchRecognizer
{
    pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchPress:)];
    [pinchRecognizer setDelegate:self];
    [self.view addGestureRecognizer:pinchRecognizer];
    
    mCurrentScale = 0;
    mLastScale = 0;
    
    maxScale = 2.0;
    minScale = 1.0;
    
}

- (void)addTapRecognizer
{
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [tapRecognizer setNumberOfTapsRequired:2];
    [tapRecognizer setDelegate:self];
    [self.view addGestureRecognizer:tapRecognizer];
    
}

- (void)addGestureRecognizers
{
    panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPress:)];
    [panRecognizer setDelegate:self];
    [self.view addGestureRecognizer:panRecognizer];
    
    longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [longPressRecognizer setDelegate:self];
    [self.view addGestureRecognizer:longPressRecognizer];
    
    pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchPress:)];
    [pinchRecognizer setDelegate:self];
    [self.view addGestureRecognizer:pinchRecognizer];
    
//    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//    [tapRecognizer setNumberOfTapsRequired:2];
//    [tapRecognizer setDelegate:self];
//    [self.view addGestureRecognizer:tapRecognizer];
    
    mCurrentScale = 0;
    mLastScale = 0;
    
}

- (void)removeGestureRecognizers
{
    [self.view removeGestureRecognizer:panRecognizer];
    [self.view removeGestureRecognizer:longPressRecognizer];
    [self.view removeGestureRecognizer:pinchRecognizer];
    [self.view removeGestureRecognizer:tapRecognizer];
}

- (void)editChartView
{
    
    chartView.scrollView.userInteractionEnabled = NO;
    chartView.scrollView.scrollEnabled = NO;
    [chartView setMultipleTouchEnabled:NO];
    [chartView setScalesPageToFit:NO];
    
}

- (void)editQuoteView
{
    quoteView.scrollView.userInteractionEnabled = NO;
    quoteView.scrollView.scrollEnabled = NO;
    [quoteView setMultipleTouchEnabled:NO];
    [quoteView setScalesPageToFit:NO];
}

- (void)editWebView
{
    webView.scrollView.userInteractionEnabled = NO;
    webView.scrollView.scrollEnabled = NO;
    [webView setMultipleTouchEnabled:NO];
    [webView setScalesPageToFit:NO];
}

- (void)editWatchListView
{
    
    
    [watchListView setMultipleTouchEnabled:NO];
    [watchListView setScrollEnabled:NO];
    //[watchListView setUserInteractionEnabled:NO];
    
}

- (void)editVideoPlayer
{
    
}

- (void)activateChartView
{
    chartView.scrollView.userInteractionEnabled = YES;
    chartView.scrollView.scrollEnabled = YES;
    [chartView setMultipleTouchEnabled:YES];
    [chartView setScalesPageToFit:YES];

}

- (void)activateQuoteView
{
    quoteView.scrollView.userInteractionEnabled = YES;
    quoteView.scrollView.scrollEnabled = YES;
    [quoteView setMultipleTouchEnabled:YES];
    [quoteView setScalesPageToFit:YES];

}

- (void)activateWebView
{
    webView.scrollView.userInteractionEnabled = YES;
    webView.scrollView.scrollEnabled = YES;
    [webView setMultipleTouchEnabled:YES];
    [webView setScalesPageToFit:YES];

}

- (void)activateWatchListView
{
    [watchListView setMultipleTouchEnabled:YES];
    [watchListView setScrollEnabled:YES];
    [watchListView setUserInteractionEnabled:YES];

}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    
    return NO;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
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
        
        //if (translation.x <= self.parentViewController.view.bounds.origin.x && translation.y <= self.parentViewController.view.bounds.origin.y){
        
        pr.view.center = CGPointMake(pr.view.center.x + translation.x, pr.view.center.y + translation.y);
        
        
        NSLog(@"Translation, %f, %f", translation.x, translation.y);
        [self.view setNeedsDisplay];
        
        
        [pr setTranslation:CGPointZero inView:self.view];
        //}
        //else{
        
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Out of Bounds" message:@"Out of Bounds" delegate:self.parentViewController.view cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        //[alert show];
        
        //}
        
        
    }
}

- (void)pinchPress:(UIPinchGestureRecognizer *)ppr
{
    NSLog(@"last scale = %f", mLastScale);
    
    if([ppr state] == UIGestureRecognizerStateBegan) {
        // Reset the last scale, necessary if there are multiple objects with different scales
        mLastScale = [ppr scale];
    }
    
    if ([ppr state] == UIGestureRecognizerStateBegan || [ppr state] == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = [[[ppr view].layer valueForKeyPath:@"transform.scale"] floatValue];
        
        // Constants to adjust the max/min values of zoom
        const CGFloat kMaxScale = 2.5;
        const CGFloat kMinScale = 0.75;
        
        CGFloat newScale = 1 -  (mLastScale - [ppr scale]);
        newScale = MIN(newScale, kMaxScale / currentScale);
        newScale = MAX(newScale, kMinScale / currentScale);
        CGAffineTransform transform = CGAffineTransformScale([[ppr view] transform], newScale, newScale);
        [ppr view].transform = transform;
        
        mLastScale = [ppr scale];  // Store the previous scale factor for the next pinch gesture call
    }
    
    
}



- (void)delete:(id)sender
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


@end
