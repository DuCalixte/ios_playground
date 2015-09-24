//
//  ViewAnimationViewController.m
//  PAFinal
//
//  Created by STANLEY CALIXTE on 5/26/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "ViewAnimationViewController.h"

@interface ViewAnimationViewController ()

@end

@implementation ViewAnimationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGRect frame = self.viewBox.frame;
    
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    frame.origin = point;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.viewBox.frame = frame;
        
        if (self.viewBox.backgroundColor == [UIColor redColor]){
            self.viewBox.backgroundColor = [UIColor greenColor];
        }
        else if (self.viewBox.backgroundColor == [UIColor greenColor]){
            self.viewBox.backgroundColor = [UIColor blueColor];
        }
        else if (self.viewBox.backgroundColor == [UIColor blueColor]){
            self.viewBox.backgroundColor = [UIColor redColor];
        }
    }];
}

- (void) awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"View Animations";
    self.viewBox.backgroundColor = [UIColor redColor];
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
