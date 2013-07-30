//
//  QuoteView.m
//  Dashboard
//
//  Created by Ray  on 7/19/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import "QuoteView.h"

@implementation QuoteView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //webUrl = @"https://apis.tdameritrade.com/apps/100/Quote?<source=TDAM:iPad>&symbol=AAPL";
        webUrl = @"https://www.google.com/finance?q=AMTD&ei=YFXtUYiUMJ3glgPfZw";
        
        
        // Top toolbar
        UIToolbar *urlBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        [urlBar setTintColor:[UIColor blackColor]];
        
        // Bottom toolbar
        UIToolbar *bottomBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 300, 300, 20)];
        [bottomBar setTintColor:[UIColor blackColor]];
        
        quoteLookup = [[UITextField alloc] initWithFrame:CGRectMake(50, 5, 200, 30)];
        [quoteLookup setBorderStyle:UITextBorderStyleRoundedRect];
        [quoteLookup setBackgroundColor:[UIColor whiteColor]];
        quoteLookup.text = @"Get Quote";
        quoteLookup.textColor = [UIColor lightGrayColor];
        quoteLookup.returnKeyType = UIReturnKeyGo;
        [quoteLookup setClearButtonMode:UITextFieldViewModeAlways];
        [quoteLookup setKeyboardType:UIKeyboardTypeURL];
        [quoteLookup setAutocapitalizationType:UITextAutocapitalizationTypeAllCharacters];
        [quoteLookup setDelegate:self];
        [urlBar addSubview:quoteLookup];
        
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
    NSString *quoteQuery = quoteLookup.text;
    //webUrl = @"https://www.google.com/finance?q=%@&ei=YFXtUYiUMJ3glgPfZw", quoteQuery;
    //NSString *query = [quoteLookup.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    //NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://apis.tdameritrade.com/apps/100/Quote?<source=TDAM:iPad>&symbol=%@", quoteQuery]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.com/finance?q=%@&ei=YFXtUYiUMJ3glgPfZw", quoteQuery]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self loadRequest:req];
    
    [quoteLookup resignFirstResponder];
    [self setScalesPageToFit:YES];
    NSLog(@"%@", quoteQuery);
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"Quote Finished Loading");
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    quoteLookup.text = @"";
    quoteLookup.textColor = [UIColor blackColor];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *quoteQuery = quoteLookup.text;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.com/finance?q=%@&ei=YFXtUYiUMJ3glgPfZw", quoteQuery]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self loadRequest:req];
    [quoteLookup resignFirstResponder];
    [self setScalesPageToFit:YES];
    NSLog(@"%@", quoteQuery);
    [quoteLookup resignFirstResponder];
    
    //NSLog(@"%@", webUrl);
    
    if ([quoteLookup.text isEqual: @""]){
        quoteLookup.text = @"Get Quote";
        quoteLookup.textColor = [UIColor lightGrayColor];
        [quoteLookup setClearButtonMode:UITextFieldViewModeAlways];
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
