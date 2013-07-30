//
//  WebViewController.m
//  Nerdfeed
//
//  Created by Ray  on 6/26/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController



- (void)loadView
{
    // Create an instance of UIWebView as large as the screen
    CGRect screenFrame = CGRectMake(0, 40, 800, 600);
    UIWebView *wv = [[UIWebView alloc] initWithFrame:screenFrame];
    
    // Tell web view to scale web content to fit within bounds of webview
    [wv setScalesPageToFit:YES];
    
    [self setView:wv];
    
    panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPress:)];
    [panRecognizer setDelegate:self];
    [self.view addGestureRecognizer:panRecognizer];
    
    
    
    longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [longPressRecognizer setDelegate:self];
    [self.view addGestureRecognizer:longPressRecognizer];
    
    pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchPress:)];
    [pinchRecognizer setDelegate:self];
    [self.view addGestureRecognizer:pinchRecognizer];
    
    mCurrentScale = 0;
    mLastScale = 0;
}

- (UIWebView *)webView
{
    return (UIWebView *)[self view];
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
        
        
        // Get the XY touch point of view on screen
        CGPoint translation = [pr locationInView:self.view];
        
        pr.view.center = CGPointMake(pr.view.center.x + translation.x, pr.view.center.y + translation.y);
        
        
        NSLog(@"Translation, %f, %f", translation.x, translation.y);
        
        if (translation.x > self.parentViewController.view.bounds.size.width){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Out of Bounds" message:@"Out of Bounds" delegate:self.parentViewController.view cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            [self.view setNeedsDisplay];
            
            
            [pr setTranslation:CGPointZero inView:self.view];
        }
        
        
    }
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
        const CGFloat kMaxScale = 1.5;
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
    //    if ([tr state] == UIGestureRecognizerStateEnded){
    //
    //        [self.view setFrame:defaultRect];
    //        mLastScale = 0;
    //
    //    }
    
}

- (void)delete:(id)sender
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//        return YES;
//    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
//    
//}

@end
