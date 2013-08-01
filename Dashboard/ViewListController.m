//
//  ViewListController.m
//  Dashboard
//
//  Created by Ray  on 8/1/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import "ViewListController.h"
#include "MainViewController.h"


@implementation ViewListController

@synthesize delegate;
@synthesize viewListItems;
@synthesize viewListImages;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self setTableView:[[ViewList alloc] initWithFrame:CGRectMake(0, 300, 200, 310) style:UITableViewStylePlain]];
        
        viewListItems = [[NSMutableArray alloc] initWithObjects:@"Chart",@"Quote", @"News", @"Web", @"Watch List", @"Video", @"Twitter", nil];
        viewListImages = [[NSMutableArray alloc] init];
        [viewListImages addObject:[UIImage imageNamed:@"Stock Chart.jpg"]];
        [viewListImages addObject:[UIImage imageNamed:@"Stock Quote.jpg"]];
        [viewListImages addObject:[UIImage imageNamed:@"RSSLogo.jpg"]];
        [viewListImages addObject:[UIImage imageNamed:@"Web.jpg"]];
        [viewListImages addObject:[UIImage imageNamed:@"WatchList.jpg"]];
        [viewListImages addObject:[UIImage imageNamed:@"Video.jpg"]];
        [viewListImages addObject:[UIImage imageNamed:@"twitterLogo.jpg"]];
        
        
        
    }
    
    return self;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [viewListItems objectAtIndex:[indexPath row]];
    cell.imageView.image = [viewListImages objectAtIndex:[indexPath row]];
    
        
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row]) {
        case 0:
            [self.delegate addChart:self];
            break;
        case 1:
            [self.delegate addQuote:self];
            break;
        case 2:
            [self.delegate addNews:self];
            break;
        case 3:
            [self.delegate addWeb:self];
            break;
        case 4:
            [self.delegate addWatchList:self];
            break;
        case 5:
            [self.delegate addVideo:self];
            break;
        case 6:
            [self.delegate addTwitter:self];
            break;
            
        default:
            break;
    }
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
    
    
}


- (void)removeGestureRecognizers
{
    [self.view removeGestureRecognizer:panRecognizer];
    [self.view removeGestureRecognizer:longPressRecognizer];
    [self.view removeGestureRecognizer:pinchRecognizer];
    
}

- (void)editViewList
{
    
    [self.tableView setMultipleTouchEnabled:NO];
    [self.tableView setScrollEnabled:NO];
    [self.tableView setAllowsSelection:NO];
    
    
    
}

- (void)activateViewList
{
    [self.tableView setUserInteractionEnabled:YES];
    [self.tableView setMultipleTouchEnabled:YES];
    [self.tableView setAllowsSelection:YES];
    [self.tableView setScrollEnabled:YES];
    
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
    
    [self.tableView setNeedsDisplay];
    
    
    
}


- (void)panPress:(UIPanGestureRecognizer *)pr
{
    if ([pr state] == UIGestureRecognizerStateChanged){
        NSLog(@"Panning Began");
        
        [self.parentViewController.view bringSubviewToFront:self.view];
        // Get the XY touch point of view on screen
        CGPoint translation = [pr locationInView:self.view];
        
        // Padding to place finger in the center of the view
        CGPoint padding = CGPointMake(100, 150);
        
        translation.x -= padding.x;
        translation.y -= padding.y;
        
        pr.view.center = CGPointMake(pr.view.center.x + translation.x, pr.view.center.y + translation.y);
        
        
        NSLog(@"Translation, %f, %f", translation.x, translation.y);
        
        
        
        [self.view setNeedsDisplay];
        
        
        [pr setTranslation:CGPointZero inView:self.view];
        
        
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



- (void)delete:(id)sender
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}



@end
