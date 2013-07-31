//
//  ScrollViewController.h
//  Dashboard
//
//  Created by Ray  on 7/12/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MainView.h"
//#import "ChartViewController.h"
//#import "DashboardWebViewController.h"
#import "ListViewController.h"
//#import "QuoteViewController.h"
//#import "WatchListViewController.h"
#import "RayViewController.h"
#import "TwitterViewController.h"

@interface MainViewController : UIViewController<UIGestureRecognizerDelegate, UITextFieldDelegate, UIWebViewDelegate>
{
    
    
    
    
    UILabel *appLabel;
    UITextField *symbolLookup;
    NSString *stockSymbol;
    UIButton *editButton;
    UIButton *doneButton;
    UIButton *chartButton;
    UIButton *newsButton;
    UIButton *quoteButton;
    UIButton *webButton;
    UIButton *watchListButton;
    UIButton *videoButton;
    UIButton *twitterButton;
    
}

@property (strong, nonatomic)RayViewController *chartView;
@property (strong, nonatomic)RayViewController *quoteView;
@property (strong, nonatomic)RayViewController *webView;
@property (strong, nonatomic)RayViewController *watchListView;
@property (strong, nonatomic)ListViewController *newsView;
@property (strong, nonatomic)RayViewController *videoPlayer;
@property (strong, nonatomic)TwitterViewController *twitterView;

@property (strong, nonatomic)NSMutableArray *chartViewControllerArray;
@property (strong, nonatomic)NSMutableArray *quoteViewControllerArray;
@property (strong, nonatomic)NSMutableArray *webViewControllerArray;
@property (strong, nonatomic)NSMutableArray *watchListViewControllerArray;
@property (strong, nonatomic)NSMutableArray *newsViewControllerArray;
@property (strong, nonatomic)NSMutableArray *videoPlayerControllerArray;
@property (strong, nonatomic)NSMutableArray *twitterViewControllerArray;

- (void)addChart:(id)sender;
- (void)addNews:(id)sender;
- (void)addQuote:(id)sender;
- (void)addWeb:(id)sender;
- (void)addWatchList:(id)sender;
- (void)addVideo:(id)sender;
- (void)addTwitter:(id)sender;
- (void)edit:(id)sender;
- (void)done:(id)sender;






@end
