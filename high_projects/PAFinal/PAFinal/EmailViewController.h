//
//  EmailViewController.h
//  PAFinal
//
//  Created by STANLEY CALIXTE on 5/26/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MessageUI;
#import "FeatureManagerViewController.h"

@interface EmailViewController : FeatureManagerViewController<UITextFieldDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailSubject;
@property (weak, nonatomic) IBOutlet UITextView *emailContent;

- (IBAction)sendEmail:(id)sender;
@end
