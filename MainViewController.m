//
//  ScrollViewController.m
//  Dashboard
//
//  Created by Ray  on 7/12/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import "MainViewController.h"
#import "ChartView.h"


@implementation MainViewController

@synthesize viewList;
@synthesize chartView;
@synthesize quoteView;
@synthesize webView;
@synthesize watchListView;
@synthesize newsView;
@synthesize videoPlayer;
@synthesize twitterView;
@synthesize chartViewControllerArray;
@synthesize quoteViewControllerArray;
@synthesize webViewControllerArray;
@synthesize watchListViewControllerArray;
@synthesize newsViewControllerArray;
@synthesize videoPlayerControllerArray;
@synthesize twitterViewControllerArray;
@synthesize viewListControllerArray;


- (void)loadView
{
    [self setView:[[MainView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)]];
    
    NSLog(@"Bounds Width:%f\n Bounds Hieght:%f", self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)viewDidLoad
{
    
    NSLog(@"View Did Load");
    
    // Create chartViewController Array
    chartViewControllerArray = [[NSMutableArray alloc] init];
    
    // Create quoteViewController Array
    quoteViewControllerArray = [[NSMutableArray alloc] init];
    
    // Create webViewController Array
    webViewControllerArray = [[NSMutableArray alloc] init];
    
    // Create watchListViewController Array
    watchListViewControllerArray = [[NSMutableArray alloc] init];
    
    // Create newsViewController Array
    newsViewControllerArray = [[NSMutableArray alloc] init];
    
    // Create videoPlayerController Array
    videoPlayerControllerArray = [[NSMutableArray alloc] init];
    
    // Create twitterViewController Array
    twitterViewControllerArray = [[NSMutableArray alloc] init];
    
    // Create viewListController Array
    viewListControllerArray = [[NSMutableArray alloc] init];
    
    
    // Create Top Toolbar
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 1024, 40)];
    [toolBar setTintColor:[UIColor blackColor]];
    
    // Create App Label
    appLabel = [[UILabel alloc] initWithFrame:CGRectMake(385, 5, 250, 30)];
    [appLabel setText:@"TDA Mobile Dashboard"];
    [appLabel setTextAlignment:NSTextAlignmentCenter];
    [appLabel setBackgroundColor:[UIColor clearColor]];
    [appLabel setFont:[UIFont systemFontOfSize:20]];
    [appLabel setTextColor:[UIColor greenColor]];
    [toolBar addSubview:appLabel];
    
    // Create Symbol Lookup Text Field
    symbolLookup = [[UITextField alloc] initWithFrame:CGRectMake(825, 5, 195, 30)];
    [symbolLookup setBackgroundColor:[UIColor whiteColor]];
    [symbolLookup setTextAlignment:NSTextAlignmentCenter];
    [symbolLookup setBorderStyle:UITextBorderStyleRoundedRect];
    symbolLookup.text = @"Symbol Lookup";
    symbolLookup.textColor = [UIColor lightGrayColor];
    symbolLookup.returnKeyType = UIReturnKeyGo;
    [symbolLookup setClearButtonMode:UITextFieldViewModeAlways];
    [symbolLookup setAutocapitalizationType:UITextAutocapitalizationTypeAllCharacters];
    
    [symbolLookup setDelegate:self];
    [toolBar addSubview:symbolLookup];
    
    // Add Edit Button to tool bar
    editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchDown];
    [editButton setTitle:@"Edit" forState:UIControlStateNormal];
    editButton.frame = CGRectMake(5, 5, 80, 30);
    [toolBar addSubview:editButton];
    [self.view addSubview:toolBar];
    
    // Add Done Button to tool bar
    doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [doneButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchDown];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    doneButton.frame = CGRectMake(5, 5, 80, 30);
    [doneButton setHidden:YES];
    [doneButton setEnabled:NO];
    [toolBar addSubview:doneButton];
    [self.view addSubview:toolBar];
    
    
    
    
    // Create Bottom Toolbar
    UIToolbar *bToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 700, 1024, 50)];
    [bToolBar setTintColor:[UIColor blackColor]];
    
    // Add Add View Button and attach to toolbar
    addViewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addViewButton addTarget:self action:@selector(addView:) forControlEvents:UIControlEventTouchDown];
    [addViewButton setTitle:@"Add View" forState:UIControlStateNormal];
    addViewButton.frame = CGRectMake(5, 10, 100, 30);
    [bToolBar addSubview:addViewButton];
    [self.view addSubview:bToolBar];
    
////    // Add Chart View button and Add to Bottom Toolbar
////    chartButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
////    [chartButton addTarget:self action:@selector(addChart:) forControlEvents:UIControlEventTouchDown];
////    [chartButton setTitle:@"Chart" forState:UIControlStateNormal];
////    chartButton.frame = CGRectMake(5, 10, 100, 30);
////    [bToolBar addSubview:chartButton];
////    [self.view addSubview:bToolBar];
//    
//    // Add News View Button and Add to Bottom Toolbar
//    newsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [newsButton addTarget:self action:@selector(addNews:) forControlEvents:UIControlEventTouchDown];
//    [newsButton setTitle:@"News" forState:UIControlStateNormal];
//    newsButton.frame = CGRectMake(180, 10, 100, 30);
//    [bToolBar addSubview:newsButton];
//    [self.view addSubview:bToolBar];
//    
//    // Add Quote View button and Add to Bottom Toolbar
//    quoteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [quoteButton addTarget:self action:@selector(addQuote:) forControlEvents:UIControlEventTouchDown];
//    [quoteButton setTitle:@"Quote" forState:UIControlStateNormal];
//    quoteButton.frame = CGRectMake(370, 10, 100, 30);
//    [bToolBar addSubview:quoteButton];
//    [self.view addSubview:bToolBar];
//    
//    // Add Web View button and Add to Bottom Toolbar
//    webButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [webButton addTarget:self action:@selector(addWeb:) forControlEvents:UIControlEventTouchDown];
//    [webButton setTitle:@"Web" forState:UIControlStateNormal];
//    webButton.frame = CGRectMake(550, 10, 100, 30);
//    [bToolBar addSubview:webButton];
//    [self.view addSubview:bToolBar];
//    
//    // Add WatchList View button and Add to Bottom Toolbar
//    watchListButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [watchListButton addTarget:self action:@selector(addWatchList:) forControlEvents:UIControlEventTouchDown];
//    [watchListButton setTitle:@"Watch List" forState:UIControlStateNormal];
//    watchListButton.frame = CGRectMake(740, 10, 100, 30);
//    [bToolBar addSubview:watchListButton];
//    [self.view addSubview:bToolBar];
//    
//    // Add Video Player button and Add to Bottom Toolbar
//    videoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [videoButton addTarget:self action:@selector(addVideo:) forControlEvents:UIControlEventTouchDown];
//    [videoButton setTitle:@"Video" forState:UIControlStateNormal];
//    videoButton.frame = CGRectMake(920, 10, 50, 30);
//    [bToolBar addSubview:videoButton];
//    [self.view addSubview:bToolBar];
//    
//    // Add Twitter button and Add to Bottom Toolbar
//    twitterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [twitterButton addTarget:self action:@selector(addTwitter:) forControlEvents:UIControlEventTouchDown];
//    [twitterButton setTitle:@"Twitter" forState:UIControlStateNormal];
//    twitterButton.frame = CGRectMake(970, 10, 50, 30);
//    [bToolBar addSubview:twitterButton];
//    [self.view addSubview:bToolBar];
    

}

- (void)didReceiveMemoryWarning
{
    NSLog(@"Memory Warning");
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    symbolLookup.text = @"";
    symbolLookup.textColor = [UIColor blackColor];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    stockSymbol = symbolLookup.text;
    [symbolLookup resignFirstResponder];
    
    NSLog(@"%@", stockSymbol);
    
    if ([symbolLookup.text isEqual: @""]){
        symbolLookup.text = @"Symbol Lookup";
        symbolLookup.textColor = [UIColor lightGrayColor];
        [symbolLookup setClearButtonMode:UITextFieldViewModeAlways];
    }
    
    return YES;
}

- (void)addView:(id)sender
{
    int i = 0;
    viewList = [[ViewListController alloc] init];
    [viewListControllerArray insertObject:viewList atIndex:i];
    
    [self.view addSubview:viewList.view];
    [self addChildViewController:[viewListControllerArray objectAtIndex:i]];
    [[viewListControllerArray objectAtIndex:i] didMoveToParentViewController:self];
    viewList.delegate = self;
}

- (void)addChart:(id)sender
{
    int i = 0;
    chartView = [[RayViewController alloc] init];
    [chartView loadChartView];
    [chartViewControllerArray insertObject:chartView atIndex:i];
    
        
    [self.view addSubview:chartView.view];
    [self addChildViewController:[chartViewControllerArray objectAtIndex:i]];
    [[chartViewControllerArray objectAtIndex:i] didMoveToParentViewController:self];
    
    
    
    
    i++;
    
    
    
    
    
}

- (void)addNews:(id)sender
{
    int i = 0;
    newsView = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
    [newsViewControllerArray insertObject:newsView atIndex:i];
    
    [self.view addSubview:newsView.view];
    [self addChildViewController:[newsViewControllerArray objectAtIndex:i]];
    [[newsViewControllerArray objectAtIndex:i] didMoveToParentViewController:self];
    
    i++;
    


}

- (void)addTwitter:(id)sender
{
    int i = 0;
    twitterView = [[TwitterViewController alloc] initWithStyle:UITableViewStylePlain];
    [twitterViewControllerArray insertObject:twitterView atIndex:i];
    
    [self.view addSubview:twitterView.view];
    [self addChildViewController:[twitterViewControllerArray objectAtIndex:i]];
    [[twitterViewControllerArray objectAtIndex:i] didMoveToParentViewController:self];
    
    i++;
    
}

- (void)addQuote:(id)sender
{
    int i = 0;
    quoteView = [[RayViewController alloc] init];
    [quoteView loadQuoteView];
    [quoteViewControllerArray insertObject:quoteView atIndex:i];
    
    
    [self.view addSubview:quoteView.view];
    [self addChildViewController:[quoteViewControllerArray objectAtIndex:i]];
    [[quoteViewControllerArray objectAtIndex:i] didMoveToParentViewController:self];
    
    
    
    i++;

    
}

- (void)addWeb:(id)sender
{
    int i = 0;
    webView = [[RayViewController alloc] init];
    [webView loadWebView];
    [webViewControllerArray insertObject:webView atIndex:i];
    
    
    [self.view addSubview:webView.view];
    [self addChildViewController:[webViewControllerArray objectAtIndex:i]];
    [[webViewControllerArray objectAtIndex:i] didMoveToParentViewController:self];
    
    
    
    i++;
    
}

- (void)addVideo:(id)sender
{
    int i = 0;
    videoPlayer = [[RayViewController alloc] init];
    [videoPlayer loadMoviePlayer];
    [videoPlayerControllerArray insertObject:videoPlayer atIndex:i];
    
    [self.view addSubview:videoPlayer.view];
    [self addChildViewController:[videoPlayerControllerArray objectAtIndex:i]];
    [[videoPlayerControllerArray objectAtIndex:i] didMoveToParentViewController:self];
    
    i++;
}

- (void)addWatchList:(id)sender
{
    int i = 0;
    watchListView = [[RayViewController alloc] init];
    [watchListView loadWatchListView];
    [watchListViewControllerArray insertObject:watchListView atIndex:i];
    
    
    [self.view addSubview:watchListView.view];
    [self addChildViewController:[watchListViewControllerArray objectAtIndex:i]];
    [[watchListViewControllerArray objectAtIndex:i] didMoveToParentViewController:self];
    
    
    i++;

}



- (void)edit:(id)sender
{
    
    for (RayViewController *chartSubView in chartViewControllerArray) {
        [chartSubView addGestureRecognizers];
        [chartSubView editChartView];
        //NSLog(@"%@", subView1);
    }
    
    for (RayViewController *quoteSubView in quoteViewControllerArray) {
        [quoteSubView addGestureRecognizers];
        [quoteSubView editQuoteView];
    }
    
    for (RayViewController *webSubView in webViewControllerArray) {
        [webSubView addGestureRecognizers];
        [webSubView editWebView];
    }
    
    for (RayViewController *watchListSubView in watchListViewControllerArray) {
        [watchListSubView addGestureRecognizers];
        [watchListSubView editWatchListView];
    }
    
    for (RayViewController *videoSubView in videoPlayerControllerArray) {
        [videoSubView addGestureRecognizers];
        [videoSubView editVideoPlayer];
    }
    
    for (ListViewController *newsViewSubView in newsViewControllerArray) {
        [newsViewSubView addGestureRecognizers];
        [newsViewSubView editNewsView];
    }
    
    for (TwitterViewController *twitterSubView in twitterViewControllerArray) {
        [twitterSubView addGestureRecognizers];
        [twitterSubView editTwitterView];
    }
    
    for (ViewListController *viewListSubView in viewListControllerArray) {
        [viewListSubView addGestureRecognizers];
        [viewListSubView editViewList];
    }
    
    
    if ([editButton isTouchInside]) {
        
        [editButton setEnabled:NO];
        [editButton setHidden:YES];
        [doneButton setEnabled:YES];
        [doneButton setHidden:NO];
        
    }
    
    [chartButton setEnabled:NO];
    [newsButton setEnabled:NO];
    [quoteButton setEnabled:NO];
    [webButton setEnabled:NO];
    [watchListButton setEnabled:NO];
    [videoButton setEnabled:NO];
    [twitterButton setEnabled:NO];
    [addViewButton setEnabled:NO];
    
}

- (void)done:(id)sender
{

    for (RayViewController *chartSubView in chartViewControllerArray) {
            [chartSubView removeGestureRecognizers];
            [chartSubView activateChartView];
            //NSLog(@"%@", subView);
    }
    
    for (RayViewController *quoteSubView in quoteViewControllerArray) {
        [quoteSubView removeGestureRecognizers];
        [quoteSubView activateQuoteView];
    }
    
    for (RayViewController *webSubView in webViewControllerArray) {
        [webSubView removeGestureRecognizers];
        [webSubView activateWebView];
    }
    
    for (RayViewController *watchListSubView in watchListViewControllerArray) {
        [watchListSubView removeGestureRecognizers];
        [watchListSubView activateWatchListView];
    }
    
    for (RayViewController *videoSubView in videoPlayerControllerArray) {
        [videoSubView removeGestureRecognizers];
    }
    
    for (ListViewController *newsViewSubView in newsViewControllerArray) {
        [newsViewSubView removeGestureRecognizers];
        [newsViewSubView activateNewsView];
    }
    
    for (TwitterViewController *twitterSubView in twitterViewControllerArray) {
        [twitterSubView removeGestureRecognizers];
        [twitterSubView activateTwitterView];
    }
    
    for (ViewListController *viewListSubView in viewListControllerArray) {
        [viewListSubView removeGestureRecognizers];
        [viewListSubView activateViewList];
    }


        

    
    if ([doneButton isTouchInside]){
        
        [doneButton setEnabled:NO];
        [doneButton setHidden:YES];
        [editButton setEnabled:YES];
        [editButton setHidden:NO];
    }
    
    [chartButton setEnabled:YES];
    [newsButton setEnabled:YES];
    [quoteButton setEnabled:YES];
    [webButton setEnabled:YES];
    [watchListButton setEnabled:YES];
    [videoButton setEnabled:YES];
    [twitterButton setEnabled:YES];
    [addViewButton setEnabled:YES];
    
    NSLog(@"Done Pressed");
    
}

- (void)printSubViewInView
{
    for (RayViewController *rc in self.view.subviews) {
        NSLog(@"%@", rc);
    }
}


@end
