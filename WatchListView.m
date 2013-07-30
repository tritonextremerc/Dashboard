//
//  WatchListView.m
//  Dashboard
//
//  Created by Ray  on 7/22/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import "WatchListView.h"

@implementation WatchListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        tableView = [[UITableView alloc] initWithFrame:frame];
        
        // Top toolbar
        UIToolbar *topBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        [topBar setTintColor:[UIColor blackColor]];
        
        UILabel *symbol = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, 80, 20)];
        [symbol setTextColor:[UIColor whiteColor]];
        [symbol setBackgroundColor:[UIColor clearColor]];
        [symbol setText:@"Symbol"];
        
        UILabel *last = [[UILabel alloc] initWithFrame:CGRectMake(85, 8, 50, 20)];
        [last setTextColor:[UIColor whiteColor]];
        [last setBackgroundColor:[UIColor clearColor]];
        [last setText:@"Last"];
        
        UILabel *bidAsk = [[UILabel alloc] initWithFrame:CGRectMake(145, 8, 80, 20)];
        [bidAsk setTextColor:[UIColor whiteColor]];
        [bidAsk setBackgroundColor:[UIColor clearColor]];
        [bidAsk setText:@"Bid/Ask"];
        
        UILabel *change = [[UILabel alloc] initWithFrame:CGRectMake(230, 8, 80, 20)];
        [change setTextColor:[UIColor whiteColor]];
        [change setBackgroundColor:[UIColor clearColor]];
        [change setText:@"Change"];
        
        [topBar addSubview:symbol];
        [topBar addSubview:last];
        [topBar addSubview:bidAsk];
        [topBar addSubview:change];
        
        
        // Bottom toolbar
        UIToolbar *bottomBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 605, 300, 20)];
        [bottomBar setTintColor:[UIColor blackColor]];
        
        [self addSubview:topBar];
        [self addSubview:bottomBar];
        [self setMultipleTouchEnabled:YES];
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
