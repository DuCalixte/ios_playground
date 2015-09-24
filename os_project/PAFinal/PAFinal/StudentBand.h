//
//  StudentBand.h
//  PAFinal
//
//  Created by STANLEY CALIXTE on 3/9/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "Student.h"
#define KEY_INSTRUMENT @"KeyInstrument"

@interface StudentBand : Student

@property (nonatomic, strong) NSString *instrument;

-(id)init;
-(id)initWithName:(NSString *)name andNumber:(int)number andInstrument:(NSString *)inst;
-(id)initWithName:(NSString *)name andNumber:(int)number andInstrument:(NSString *)inst andDate:(NSDate *)date;

- (void)encodeWithCoder:(NSCoder *)aCoder;
-(NSString *)description;
@end
