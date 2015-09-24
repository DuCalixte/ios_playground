//
//  ContactsViewController.h
//  PAFinal
//
//  Created by STANLEY CALIXTE on 5/26/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AddressBook;
@import AddressBookUI;
#import "FeatureManagerViewController.h"

@interface ContactsViewController : FeatureManagerViewController<ABPeoplePickerNavigationControllerDelegate>//,UIPopoverControllerDelegate>

@property (strong, nonatomic) ABPeoplePickerNavigationController *pickerNavigationController;

- (void) cancelContactUI;
@end
