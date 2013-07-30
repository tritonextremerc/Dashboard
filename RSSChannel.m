//
//  RSSChannel.m
//  Nerdfeed
//
//  Created by Ray  on 6/25/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import "RSSChannel.h"
#import "RSSItem.h"

@implementation RSSChannel

@synthesize title, infoString, parentParserDelegate;

- (id)init
{
    self = [super init];
    
    if (self){
        // Create a container for the RSSItems this channel has
        _items = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t%@ found a %@ element", self, elementName);
    
    if ([elementName isEqual:@"title"]){
        currentString = [[NSMutableString alloc] init];
        [self setTitle:currentString];
    }
    else if ([elementName isEqual:@"description"]){
        currentString = [[NSMutableString alloc] init];
        [self setInfoString:currentString];
    }
    else if ([elementName isEqual:@"item"]){
        // When we find an item, create an instance of RSSItem
        RSSItem *entry = [[RSSItem alloc] init];
        
        // Set up its parent as ourselves so we can regain control of the parser
        [entry setParentParserDelegate:self];
        
        // Turn the parser to the RSSItem
        [parser setDelegate:entry];
        
        // Add the item to our array and release our hold on it
        [_items addObject:entry];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // If we were in an element that we were collecting the string for
    // this appropriately releases our hold on it and the permanent ivar keeps
    // ownership of it. If we weren't parsing such an element, currentString
    // is already nil
    currentString = nil;
    
    // If the element that ended was the channel, give up control to
    // who gave us control in the first place
    if ([elementName isEqual:@"channel"]){
        [parser setDelegate:parentParserDelegate];
    }
}

@end
