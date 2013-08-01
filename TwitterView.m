//
//  TwitterView.m
//  Dashboard
//
//  Created by Ray  on 7/31/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import "TwitterView.h"

@implementation TwitterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // Top toolbar
        UIToolbar *topBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        [topBar setTintColor:[UIColor blackColor]];
        self.tableHeaderView = topBar;
        
         //Bottom toolbar
                UIToolbar *bottomBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 600, 20)];
                [bottomBar setTintColor:[UIColor blackColor]];
        
        self.tableFooterView = bottomBar;
        //[self addSubview:bottomBar];
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];

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
