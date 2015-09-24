//
//  WebServiceViewController.h
//  PAFinal
//
//  Created by STANLEY CALIXTE on 3/12/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebServiceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *temp_textfield;
- (IBAction)convert_temp_button:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *temp_converted_label;

@end
