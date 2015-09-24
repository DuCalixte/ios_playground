//
//  ConcurrencyViewController.h
//  PAFinal
//
//  Created by STANLEY CALIXTE on 5/26/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureManagerViewController.h"

@interface ConcurrencyViewController : FeatureManagerViewController

@property (weak, nonatomic) IBOutlet UILabel *nstimer;
@property (weak, nonatomic) IBOutlet UILabel *nsobject;
@property (weak, nonatomic) IBOutlet UILabel *nsthread;
@property (weak, nonatomic) IBOutlet UILabel *nsoperationqueue;
@property (weak, nonatomic) IBOutlet UILabel *gcd;

@end
