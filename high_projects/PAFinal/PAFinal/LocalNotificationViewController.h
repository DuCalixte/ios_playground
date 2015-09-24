//
//  LocalNotificationViewController.h
//  PAFinal
//
//  Created by STANLEY CALIXTE on 5/26/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureManagerViewController.h"

@interface LocalNotificationViewController : FeatureManagerViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)scheduleNotification:(id)sender;

@end
