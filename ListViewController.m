//
//  ListViewController.m
//  Nerdfeed
//
//  Created by Ray  on 6/25/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import "ListViewController.h"
#import "RSSChannel.h"
#import "RSSItem.h"
#import "WebViewController.h"

@implementation ListViewController

@synthesize webViewController;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ found a %@ element", self, elementName);
    if ([elementName isEqual:@"channel"]){
        // If the parser saw a channel, create new instance, store in our ivar
        channel = [[RSSChannel alloc] init];
        
        // Give the channel object a pointer back to ourselves for later
        [channel setParentParserDelegate:self];
        
        // Set the parser's delegate to the channel object
        [parser setDelegate:channel];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self){
        [self setTableView:[[ListView alloc] initWithFrame:CGRectMake(320, 50, 300, 600)]];
        [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
        
        [self fetchEntries];
        
        NSLog(@"Initialized");
        
//        panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPress:)];
//        [panRecognizer setDelegate:self];
//        [self.view addGestureRecognizer:panRecognizer];
//        
//        
//        
//        longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//        [longPressRecognizer setDelegate:self];
//        [self.view addGestureRecognizer:longPressRecognizer];
//        
//        pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchPress:)];
//        [pinchRecognizer setDelegate:self];
//        [self.view addGestureRecognizer:pinchRecognizer];
//        
//        mCurrentScale = 0;
//        mLastScale = 0;
        
        

    }
    
    return self;
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
    //[self.view removeGestureRecognizer:tapRecognizer];
}

- (void)editNewsView
{
    
    [listView setMultipleTouchEnabled:NO];
    [listView setScrollEnabled:NO];
    [listView setUserInteractionEnabled:NO];
    //[watchListView setUserInteractionEnabled:NO];
    
}

- (void)activateNewsView
{
    [listView setUserInteractionEnabled:YES];
    [listView setMultipleTouchEnabled:YES];
    [listView setScrollEnabled:YES];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[channel items]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    RSSItem *item = [[channel items] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[item title]];
    [[cell textLabel] setFont:[UIFont systemFontOfSize:14.0]];
    
    
    
    return cell;
}

- (void)fetchEntries
{
    // Create a new data container for the stuff that comes back from the service
    xmlData = [[NSMutableData alloc] init];
    
    // Construct a URL that will ask the service for what you want -
    // note we can concatenate literal strings together on multiple
    // lines in this way - this results in a single NSString instance
    NSURL *url = [NSURL URLWithString:@"http://forums.bignerdranch.com/smartfeed.php?"
                  @"limit=1_DAY&sort_by=standard&feed_type=RSS2.0&feed_style=COMPACT"];
    
    // Put that URL into an NSURLRequest
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    // Create a connection that will exchange this request for data from the URL
    urlConnection = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
}

// This method will be called several times as the data arrives

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    // Add the incoming chunk of data to the container we are keeping
    // The data always comes in the correct order
    [xmlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    // We are just checking to make sure we are getting the XML
//    NSString *xmlCheck = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"xmlCheck = %@", xmlCheck);
    
    // Create the parser object with the data received from the web service
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    
    // Give it a delegate
    [parser setDelegate:self];
    
    // Tell it to start parsing - the document will be parsed and
    // the delegate of NSXMLParser will get all of its delegate messages
    // sent to it before this line finishes execution - it is blocking
    [parser parse];
    
    // Get rid of the XML data as we no longer need it
    xmlData = nil;
    
    // Get rid of the connection as we no longer need it
    connection = nil;
    
    // Reload the table
    [[self tableView] reloadData] ;
    NSLog(@"%@\n %@\n %@\n", channel, [channel title], [channel infoString]);
}

-(void)connection:(NSURLConnection *)conn didFailWithError:(NSError *)error
{
    // Release the connection object
    xmlData = nil;
    
    // Grab the description of the error object passed to us
    NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@",[error localizedDescription]];
    
    // Create and show an alert view with this error displayed
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [av show];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Push the web view controller onto the navigation stack - this implicitly
    // creates the web view controller's view the first time through
//    if (![self splitViewController])
//    [self pushViewController:webViewController animated:YES];
    
    // Initialize WebViewController view in a Popover
    
    webViewController = [[WebViewController alloc] init];
    popover = [[UIPopoverController alloc] initWithContentViewController:webViewController];
    [popover setDelegate:self];
    popover.popoverContentSize = CGSizeMake(600, 600);
    [popover presentPopoverFromRect:CGRectMake(600, 40, 0, 0) inView:self.parentViewController.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    
    // Grab the selected item
    RSSItem *entry = [[channel items] objectAtIndex:[indexPath row]];
    
    // Construct a URL with the link string of the item
    NSURL *url = [NSURL URLWithString:[entry link]];
    
    // Construct a request object with that URL
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    // Load the request into the web view
    [[webViewController webView] loadRequest:req];
    
    // Set the title of the web view controller's navigation item
    //[[webViewController navigationItem] setTitle:[entry title]];
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
        CGPoint padding = CGPointMake(140, 140);
        
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
        const CGFloat kMaxScale = 1.0;
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
