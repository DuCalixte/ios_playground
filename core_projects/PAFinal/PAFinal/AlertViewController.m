//
//  FirstViewController.m
//  PAFinal
//
//  Created by STANLEY CALIXTE on 3/12/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "AlertViewController.h"

@interface AlertViewController ()<UIAlertViewDelegate>

@end

@implementation AlertViewController

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.alert_w_yes_no_label.text = [NSString stringWithFormat:@"\"%@\" was selected", buttonIndex == 0 ? @"NO":@"YES"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.alert_w_yes_no_label.text = nil;
}

- (void) viewDidUnload
{
    [self setAlert_w_yes_no_label:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)alert_ok_button:(id)sender {
    self.alert_w_yes_no_label.text = nil;
    UIAlertView *alert =
    [[UIAlertView alloc]initWithTitle:@"Alert w/OK" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}
- (IBAction)alert_w_yes_no_button:(id)sender {
    UIAlertView *alert =
    [[UIAlertView alloc]initWithTitle:@"Alert w/Yes/No" message:nil delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
}

@end
