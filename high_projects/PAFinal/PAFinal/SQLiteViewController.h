//
//  SQLiteViewController.h
//  PAFinal
//
//  Created by STANLEY CALIXTE on 5/26/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "FeatureManagerViewController.h"

@interface SQLiteViewController : FeatureManagerViewController

@property (weak, nonatomic) IBOutlet UITextView *textContent;

@end
