//
//  ViewListController.h
//  Dashboard
//
//  Created by Ray  on 8/1/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewList.h"

@protocol ChildViewControllerDelegate <NSObject>

- (void)addView:(id)sender;
- (void)addChart:(id)sender;
- (void)addNews:(id)sender;
- (void)addQuote:(id)sender;
- (void)addWeb:(id)sender;
- (void)addWatchList:(id)sender;
- (void)addVideo:(id)sender;
- (void)addTwitter:(id)sender;

@end


@interface ViewListController : UITableViewController<UITableViewDelegate, UIGestureRecognizerDelegate>
{
    UILongPressGestureRecognizer *longPressRecognizer;
    UIPanGestureRecognizer *panRecognizer;
    UIPinchGestureRecognizer *pinchRecognizer;
    
    CGFloat mCurrentScale;
    CGFloat mLastScale;
}

@property (assign) id <ChildViewControllerDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *viewListItems;
@property (strong, nonatomic) NSMutableArray *viewListImages;


- (void)addGestureRecognizers;
- (void)removeGestureRecognizers;
- (void)editViewList;
- (void)activateViewList;



@end
