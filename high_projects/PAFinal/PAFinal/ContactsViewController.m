//
//  ContactsViewController.m
//  PAFinal
//
//  Created by STANLEY CALIXTE on 5/26/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "ContactsViewController.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    self.pickerNavigationController = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.pickerNavigationController.delegate = nil;
    self.splitViewController.delegate = self;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    CFStringRef name = ABRecordCopyCompositeName(person);

    [self displayContactAlert:(__bridge NSString*)name];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return YES;
}


- (void) cancelContactUI
{
    self.pickerNavigationController = nil;
    [self dismissViewControllerAnimated:NO completion:nil];
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
    if (self)
    {
        self.pickerNavigationController = [[ABPeoplePickerNavigationController alloc]init];
    }
}


- (void) viewDidAppear:(BOOL)animated
{
    if ([self pickerNavigationController])
    {
        [self displayContacts];
    }
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        self.pickerNavigationController = nil;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Contacts";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) displayContactAlert:(NSString*)contact
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Contacts!!!" message:contact delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void) displayContacts
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        self.pickerNavigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    
        switch ([UIDevice currentDevice].orientation) {
            case UIDeviceOrientationPortrait:
            case UIDeviceOrientationPortraitUpsideDown:
            case UIDeviceOrientationUnknown:
            {
                self.pickerNavigationController.modalInPopover = YES;
            }break;
            
            default:
            {
                self.pickerNavigationController.modalInPopover = NO;
            }break;
        }
    }
    
    self.pickerNavigationController.peoplePickerDelegate = self;
    [self presentViewController:[self pickerNavigationController] animated:YES completion:nil];
}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
