//
//  FilesViewController.m
//  PAFinal
//
//  Created by STANLEY CALIXTE on 5/26/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "FilesViewController.h"

@interface FilesViewController ()

@end

@implementation FilesViewController


- (void) displayAlert:(NSString*)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!!!" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (NSString *) path
{
    return [NSHomeDirectory() stringByAppendingString:@"/Documents/myfile.txt"];
}

- (void) loadFileToView
{
    NSError *_error = nil;
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[self path]])
    {
        self.textContent.text = [NSString stringWithContentsOfFile:[self path] encoding:NSUTF8StringEncoding error:&_error];
    }
    
    if (_error){
        [self displayAlert:[_error localizedDescription]];
    }
}

- (void) saveViewToFile
{
    NSData *data = [self.textContent.text dataUsingEncoding:NSUTF8StringEncoding];
    NSError *_error = nil;
    
    [data writeToFile:[self path] options:NSDataWritingFileProtectionComplete error:&_error];
    
    if (_error){
        [self displayAlert:[_error localizedDescription]];
    }
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

- (void) viewWillAppear:(BOOL)animated
{
    [self loadFileToView];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self saveViewToFile];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Sandbox Files";
    [self.textContent becomeFirstResponder];
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



@end
