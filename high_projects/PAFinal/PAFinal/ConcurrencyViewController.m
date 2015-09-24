//
//  ConcurrencyViewController.m
//  PAFinal
//
//  Created by STANLEY CALIXTE on 5/26/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "ConcurrencyViewController.h"

@interface ConcurrencyViewController ()

@end

@implementation ConcurrencyViewController
{
    NSInteger nstimerCount;
    NSInteger nsobjectCount;
    NSInteger nsthreadCount;
    NSInteger nsopqCount;
    NSInteger nsgcdCount;
}

- (void) updateLabel: (UILabel *)label withCounter:(NSInteger)count andAppend:(NSString *)info
{
    label.text = [NSString stringWithFormat:@"%li %@",(long)count, info];
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
    [self performConcurrencies];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Concurrency";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) doTimer
{
    nstimerCount++;
    [self updateLabel:self.nstimer withCounter:nstimerCount andAppend:@" - NSTimer (1 sec)"];
}

- (void) invokeUpdateLabel:(UILabel *)id
{
    if (id == self.nsobject){
        nsobjectCount++;
        [self updateLabel:id withCounter:nsobjectCount andAppend:@" - NSObject (2 sec)"];
    }
    else if (id == self.nsthread){
        nsthreadCount++;
        [self updateLabel:self.nsthread withCounter:nsthreadCount andAppend:@" - NSThread (3 sec)"];
    }
    
}

- (void) doObjectBackground: (id) delay
{
    @autoreleasepool {
        while (YES) {
            sleep((unsigned)[delay unsignedIntegerValue]);
            [self performSelectorOnMainThread:@selector(invokeUpdateLabel:) withObject:self.nsobject waitUntilDone:YES];
        }
    }
}

- (void) doThreadBackground: (id) delay
{
    @autoreleasepool {
        while (YES) {
            sleep((unsigned)[delay unsignedIntegerValue]);
            [self performSelectorOnMainThread:@selector(invokeUpdateLabel:) withObject:self.nsthread waitUntilDone:YES];
        }
    }
}

- (void) initializeConcurrencies
{
    [self updateLabel:self.nstimer withCounter:nstimerCount andAppend:@" - NSTimer (1 sec)"];
}

- (void) performConcurrencies
{
    // NSTimer
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(doTimer) userInfo:nil repeats:YES];
    
    // NSObject
    [self performSelectorInBackground:@selector(doObjectBackground:) withObject:[NSNumber numberWithUnsignedInteger:2]];
    
    // NSThread
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(doThreadBackground:) object:[NSNumber numberWithUnsignedInteger:3]];
    [thread start];
    
    // NSOperationQueue
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        while (YES) {
            sleep(4);
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                nsopqCount++;
                [self updateLabel:self.nsoperationqueue withCounter:nsopqCount andAppend:@" - NSOperationQueue (4 sec)"];
            }];
        }
    }];
    
    // GCD - Grand Central Distpatch
    dispatch_queue_t queue = dispatch_queue_create("com.demo.myqueue", 0);
    dispatch_async(queue, ^{
        while (YES) {
            sleep(5);
            dispatch_async(dispatch_get_main_queue(), ^{
                nsgcdCount++;
                [self updateLabel:self.gcd withCounter:nsgcdCount andAppend:@" - GCD (5 sec)"];
            });
        }
    });
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
