//
//  RSSItem.h
//  Nerdfeed
//
//  Created by Ray  on 6/26/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSItem : NSObject <NSXMLParserDelegate>
{
    NSMutableString *currentString;
}

@property (nonatomic, weak) id parentParserDelegate;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *link;

@end
