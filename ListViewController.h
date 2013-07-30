//
//  ListViewController.h
//  Nerdfeed
//
//  Created by Ray  on 6/25/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "ListView.h"
// A forward declaration; we'll import the header in the .m

@class RSSChannel;
@class WebViewController;

@interface ListViewController : UITableViewController <NSXMLParserDelegate, UIGestureRecognizerDelegate, UIPopoverControllerDelegate>
{
    NSURLConnection *urlConnection;
    NSMutableData *xmlData;
    RSSChannel *channel;
    ListView *listView;
    WebViewController *webViewController;
    UIPopoverController *popover;
    UILongPressGestureRecognizer *longPressRecognizer;
    UIPanGestureRecognizer *panRecognizer;
    UIPinchGestureRecognizer *pinchRecognizer;
    
    CGFloat mCurrentScale;
    CGFloat mLastScale;

    
   
}

@property (nonatomic, strong) WebViewController *webViewController;

- (void)fetchEntries;
- (void)addGestureRecognizers;
- (void)removeGestureRecognizers;
- (void)editNewsView;
- (void)activateNewsView;

@end

// A new protocol named ListViewControllerDelegate
@protocol ListViewControllerDelegate

// Classes that conform to this protocol must implement this method:
- (void)listViewController:(ListViewController *)lvc handleObject:(id)object;





@end
