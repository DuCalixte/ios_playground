//
//  SecondViewController.m
//  PAFinal
//
//  Created by STANLEY CALIXTE on 3/12/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()

@end

@implementation TextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidUnload
{
    [self setContent_textview:nil];
    [self setContent_webview:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)display_html_button:(id)sender {
    
    [self.content_textview resignFirstResponder];
    
    NSString *content = [NSString stringWithFormat:@"<html><head><title>Text Tab</title><style><body {font-family: Times, Arial;}</style></head><body><div id=\"mainView\"><span>%@</span></div></body></html>",self.content_textview.text];
    
    [self.content_webview loadHTMLString:content baseURL:nil];

}
@end
