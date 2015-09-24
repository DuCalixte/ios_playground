//
//  SecondViewController.h
//  PAFinal
//
//  Created by STANLEY CALIXTE on 3/12/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewController : UIViewController
- (IBAction)display_html_button:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *content_textview;
@property (weak, nonatomic) IBOutlet UIWebView *content_webview;

@end
