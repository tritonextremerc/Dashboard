//
//  TwitterViewController.m
//  Dashboard
//
//  Created by Ray  on 7/31/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import "TwitterViewController.h"

@interface TwitterViewController ()

@end

@implementation TwitterViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self){
        [self setTableView:[[TwitterView alloc] initWithFrame:CGRectMake(320, 50, 600, 600)]];
        [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
        [self getTimeLine];
        
        
        NSLog(@"Initialized");
        
    }
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getTimeLine
{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        if (granted == YES){
            NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
            if ([arrayOfAccounts count] > 0) {
                ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                
                NSURL *requestURL = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/home_timeline.json"];
                
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
                [parameters setObject:@"20" forKey:@"count"];
                [parameters setObject:@"1" forKey:@"include_entities"];
                
                SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestURL parameters:parameters];
                
                postRequest.account = twitterAccount;
                
                [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    self.dataSource = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                    if (self.dataSource.count != 0){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tableView reloadData];
                        });
                    }
                }];
            }
        } else{
            // Handle failure to get account access
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Accessing Account" message:@"Could Not Access your Twitter Account" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:@"Cancel", nil];
            [alertView show];
            [self getTimeLine];
        }
    }];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *tweet = _dataSource[[indexPath row]];
    [[cell textLabel] setFont:[UIFont systemFontOfSize:12.0]];
    cell.textLabel.text = tweet[@"text"];
    cell.imageView.image = [UIImage imageNamed:@"twitterLogo.jpg"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

- (void)editTwitterView
{
    
    [self.view setMultipleTouchEnabled:NO];
    [self.tableView setScrollEnabled:NO];
    //[self.view setUserInteractionEnabled:NO];
    
    
}

- (void)activateTwitterView
{
    [self.view setUserInteractionEnabled:YES];
    [self.view setMultipleTouchEnabled:YES];
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
        CGPoint padding = CGPointMake(280, 280);
        
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
