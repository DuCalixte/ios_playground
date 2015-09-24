//
//  FirstViewController.h
//  PAFinal
//
//  Created by STANLEY CALIXTE on 3/12/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertViewController : UIViewController
- (IBAction)alert_ok_button:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *alert_w_yes_no_label;
- (IBAction)alert_w_yes_no_button:(id)sender;
@end
