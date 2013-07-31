//
//  DashboardWebView.h
//  Dashboard
//
//  Created by Ray  on 7/15/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebView : UIWebView<UIWebViewDelegate, UITextFieldDelegate>
{
    
    
    NSString *webUrl;
    UITextField *urlLookup;
    
}

- (void)go:(id)sender;

@end
