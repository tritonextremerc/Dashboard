//
//  DashboardWebView.m
//  Dashboard
//
//  Created by Ray  on 7/15/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import "WebView.h"

@implementation WebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        webUrl = @"http://www.tdameritrade.com";
        
        
        // Top toolbar
        UIToolbar *urlBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        [urlBar setTintColor:[UIColor blackColor]];
        
        // Bottom toolbar
        UIToolbar *bottomBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 300, 300, 20)];
        [bottomBar setTintColor:[UIColor blackColor]];
        
        urlLookup = [[UITextField alloc] initWithFrame:CGRectMake(50, 5, 200, 30)];
        [urlLookup setBorderStyle:UITextBorderStyleRoundedRect];
        [urlLookup setBackgroundColor:[UIColor whiteColor]];
        urlLookup.text = @"Go to a Website";
        urlLookup.textColor = [UIColor lightGrayColor];
        urlLookup.returnKeyType = UIReturnKeyGo;
        [urlLookup setClearButtonMode:UITextFieldViewModeAlways];
        [urlLookup setKeyboardType:UIKeyboardTypeURL];
        [urlLookup setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [urlLookup setDelegate:self];
        [urlBar addSubview:urlLookup];
        
        UIButton *goButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [goButton addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchDown];
        [goButton setTitle:@"GO" forState:UIControlStateNormal];
        //[goButton setBackgroundColor:[UIColor greenColor]];
        [goButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        goButton.frame = CGRectMake(260, 5, 35, 25);
        [urlBar addSubview:goButton];
        
        NSURL *url = [NSURL URLWithString:webUrl];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [self loadRequest:req];
        
        [self setScalesPageToFit:YES];
        [self setUserInteractionEnabled:YES];
        [self addSubview:urlBar];
        [self addSubview:bottomBar];
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
    }
    return self;
}



- (void)go:(id)sender
{
    NSString *query = [urlLookup.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", query]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self loadRequest:req];
    [self setScalesPageToFit:YES];
    [urlLookup resignFirstResponder];
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    urlLookup.text = @"";
    urlLookup.textColor = [UIColor blackColor];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *query = [urlLookup.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", query]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self loadRequest:req];
    [self setScalesPageToFit:YES];
    [urlLookup resignFirstResponder];
    
    NSLog(@"%@", webUrl);
    
    if ([urlLookup.text isEqual: @""]){
        urlLookup.text = @"Symbol Lookup";
        urlLookup.textColor = [UIColor lightGrayColor];
        [urlLookup setClearButtonMode:UITextFieldViewModeAlways];
        [self go:self];
    }
    
    return YES;
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
