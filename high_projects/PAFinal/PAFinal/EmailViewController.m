//
//  EmailViewController.m
//  PAFinal
//
//  Created by STANLEY CALIXTE on 5/26/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "EmailViewController.h"

@interface EmailViewController ()

@end

@implementation EmailViewController


- (void) displayAlert:(NSString*)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!!!" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Hide the textfield
    [textField resignFirstResponder];
    
    return YES;
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0)
{
    switch(result)
    {
        case MFMailComposeResultCancelled:
            self.emailContent.text=@"Canceled"; break;
        case MFMailComposeResultFailed:
            self.emailContent.text=@"Email failed to send"; break;
        case MFMailComposeResultSaved:
            self.emailContent.text=@"Email draft is saved"; break;
        case MFMailComposeResultSent:
            self.emailContent.text=@"Email sent successfully"; break;
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Email";
    self.view.backgroundColor = [UIColor grayColor];
    self.emailSubject.delegate = self;
    self.emailContent.text = @"";
    [self.emailSubject becomeFirstResponder];
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

- (IBAction)sendEmail:(id)sender {
    if ([MFMailComposeViewController canSendMail]==NO){
        [self displayAlert:@"Unable to access email controls"];
        return;
    }
    
    MFMailComposeViewController *vc = [[MFMailComposeViewController alloc] init];
    vc.mailComposeDelegate = self;
    
    [vc setSubject:self.emailSubject.text];
    [vc setMessageBody:self.emailContent.text isHTML:NO];
    [vc setToRecipients:@[@"norman.mcentire@servin.com"]];
    [vc setBccRecipients:@[@"scalixte@gmail.com"]];
    
    [self presentViewController:vc animated:YES completion:nil];
}

@end
