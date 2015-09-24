//
//  Student.h
//  PAFinal
//
//  Created by STANLEY CALIXTE on 3/9/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StudentAdvisor.h"

#define KEY_NAME @"KeyName"
#define KEY_NUMBER @"KeyNumber"
#define KEY_DATE @"KeyDate"

@interface Student : NSObject<StudentAdvisorDelegate>


@property (nonatomic) int number;
@property (nonatomic, strong)NSString *fullname;
@property NSDate *startingDate;

-(id)init;
-(id)initWithName:(NSString *)name;
-(id)initWithName:(NSString *)name
        andNumber:(int)number;
-(id)initWithName:(NSString *)name
        andNumber:(int)number
          andDate:(NSDate *)date;

+(id)student;
+(id)studentWithName:(NSString *)name;
+(id)studentWithName:(NSString *)name
           andNumber:(int)number;

- (void)encodeWithCoder:(NSCoder *)aCoder;
-(NSString *)description;

@end
