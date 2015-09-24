//
//  WebServiceViewController.m
//  PAFinal
//
//  Created by STANLEY CALIXTE on 3/12/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "WebServiceViewController.h"

@interface WebServiceViewController ()

@end

@implementation WebServiceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewDidUnload
{
    [self setTemp_converted_label:nil];
    [self setTemp_textfield:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)convert_temp_button:(id)sender {
    NSString *siteUrl = [NSString stringWithFormat:@"http://www.webservicex.net/ConvertTemperature.asmx/ConvertTemp?Temperature=%@&FromUnit=degreeFahrenheit&ToUnit=degreeCelsius", self.temp_textfield.text];
    
    [self.temp_textfield resignFirstResponder];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self performSelectorInBackground:@selector(doWebService:) withObject:siteUrl];
}

- (void) doWebService:(id)object
{
    NSString *urlString = object;
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSError *error = nil;
    NSString *xmlString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    if (error)
    {
        xmlString = [error localizedDescription];
    }
    
    [self performSelectorOnMainThread:@selector(updateGuid:) withObject:xmlString waitUntilDone:NO];
}

- (void) updateGuid:(id)object
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString *contentString = object;
    self.temp_converted_label.text = contentString;
}
@end
