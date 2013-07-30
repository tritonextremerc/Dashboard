//
//  QuoteView.h
//  Dashboard
//
//  Created by Ray  on 7/19/13.
//  Copyright (c) 2013 ray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuoteView : UIWebView<UITextFieldDelegate, UIWebViewDelegate>
{
    
    NSString *webUrl;
    UITextField *quoteLookup;
}

@end
