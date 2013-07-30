//
//  RayViewController.h
//  Dashboard
//
//  Created by Ray  on 7/17/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ChartView.h"
#import "WebView.h"
#import "QuoteView.h"
#import "WatchListView.h"

@interface RayViewController : UIViewController<UIGestureRecognizerDelegate>
{
    UILongPressGestureRecognizer *longPressRecognizer;
    UIPanGestureRecognizer *panRecognizer;
    UITapGestureRecognizer *tapRecognizer;
    UIPinchGestureRecognizer *pinchRecognizer;
    
    CGRect defaultQuoteViewRect;
    CGRect defaultChartViewRect;
    CGRect defaultWebViewRect;
    CGRect defaultWatchListRect;
    
    CGFloat mCurrentScale;
    CGFloat mLastScale;
    
    CGFloat minScale;
    CGFloat maxScale;
}

@property (strong, nonatomic)QuoteView *quoteView;
@property (strong, nonatomic)ChartView *chartView;
@property (strong, nonatomic)WebView *webView;
@property (strong, nonatomic)WatchListView *watchListView;
@property (strong, nonatomic)MPMoviePlayerController *moviePlayer;


- (void)loadChartView;
- (void)loadQuoteView;
- (void)loadWebView;
- (void)loadWatchListView;
- (void)loadMoviePlayer;

- (void)editChartView;
- (void)editQuoteView;
- (void)editWebView;
- (void)editWatchListView;
- (void)editVideoPlayer;

- (void)activateChartView;
- (void)activateQuoteView;
- (void)activateWebView;
- (void)activateWatchListView;

- (void)addGestureRecognizers;
- (void)addLongPressRecognizer;
- (void)addPanRecognizer;
- (void)addPinchRecognizer;
- (void)addTapRecognizer;

- (void)removeGestureRecognizers;
//- (void)removeLongPressRecognizer;
//- (void)removePanRecognizer;
//- (void)removePinchRecognizer;
//- (void)removeTapRecognizer;





@end
