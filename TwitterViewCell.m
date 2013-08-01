//
//  TwitterViewCell.m
//  Dashboard
//
//  Created by Ray  on 8/1/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import "TwitterViewCell.h"

@implementation TwitterViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor redColor]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
