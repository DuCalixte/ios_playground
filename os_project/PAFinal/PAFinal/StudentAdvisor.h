//
//  StudentAdvisor.h
//  PAFinal
//
//  Created by STANLEY CALIXTE on 3/9/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StudentAdvisor;
@protocol StudentAdvisorDelegate <NSObject>
@optional
-(void)studentAdvisorDone:(StudentAdvisor *)student;
@end

@interface StudentAdvisor : NSObject
@property id<StudentAdvisorDelegate>delegate;
-(void)simulateWorkDone;
@end