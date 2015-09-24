//
//  AppDelegate.h
//  PAFinal
//
//  Created by STANLEY CALIXTE on 3/9/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "Student.h"
#import "StudentAdvisor.h"
#import "StudentBand.h"
#import "ExtendedStudentBand.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, NSURLConnectionDataDelegate, NSXMLParserDelegate, UITextFieldDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
