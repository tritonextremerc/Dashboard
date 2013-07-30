//
//  RegularView.m
//  Dashboard
//
//  Created by Ray  on 7/12/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import "ChartView.h"

@implementation ChartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"AAPL Chart" ofType:@"webarchive" inDirectory:nil]];
        [self loadRequest:[NSURLRequest requestWithURL:url]];
        [self setScalesPageToFit:YES];
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
        
        
        
        // Top toolbar
        UIToolbar *topBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
        [topBar setTintColor:[UIColor blackColor]];
        
        // Bottom toolbar
        UIToolbar *bottomBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 300, 300, 20)];
        [bottomBar setTintColor:[UIColor blackColor]];
        
        [self addSubview:topBar];
        [self addSubview:bottomBar];
        
        
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
