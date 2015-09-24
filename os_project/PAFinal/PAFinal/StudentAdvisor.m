//
//  StudentAdvisor.m
//  PAFinal
//
//  Created by STANLEY CALIXTE on 3/9/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "StudentAdvisor.h"

@implementation StudentAdvisor

-(void)simulateWorkDone
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self.delegate studentAdvisorDone:self];
}

@end
