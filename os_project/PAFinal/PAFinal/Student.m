//
//  Student.m
//  PAFinal
//
//  Created by STANLEY CALIXTE on 3/9/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "Student.h"

@implementation Student

-(id)init
{
    return [self initWithName:nil];
}

-(id)initWithName:(NSString *)name
{
    return [self initWithName:name
                    andNumber:0];
}

-(id)initWithName:(NSString *)name
        andNumber:(int)number
{
    self = [super init];
    if (self) {
        self.fullname = name;
        self.number = number;
        self.startingDate = [[NSDate alloc] init];
    }
    return self;
}

-(id)initWithName:(NSString *)name
        andNumber:(int)number andDate:(NSDate *) date
{
    self = [super init];
    if (self) {
        self.fullname = name;
        self.number = number;
        self.startingDate = date;
    }
    return self;
}


+(id)student
{
    return [[Student alloc] init];
}

+(id)studentWithName:(NSString *)name
{
    return [[Student alloc]
            initWithName:name];
}
+(id)studentWithName:(NSString *)name
           andNumber:(int)number
{
    return [[Student alloc] initWithName:name andNumber:number];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.fullname forKey:KEY_NAME];
    [aCoder encodeInt:self.number forKey:KEY_NUMBER];
    [aCoder encodeObject:self.startingDate forKey:KEY_DATE];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super init])
    {
        self.fullname = [aDecoder decodeObjectForKey:KEY_NAME];
        self.number = [aDecoder decodeIntForKey:KEY_NUMBER];
        self.startingDate = [aDecoder decodeObjectForKey:KEY_DATE];
    }
    
    return self;
}


-(void)studentAdvisorDone:(StudentAdvisor *)student
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", student);
    NSLog(@"%s", __PRETTY_FUNCTION__);
}


-(NSString *)description
{
    NSString *s = [super description];
    NSString *t = [NSString stringWithFormat:@"\nStudent Information\n"];
    NSString *s2 = [NSString stringWithFormat:@"%@%@\n-\tFull Name: %@\n-\tNumber: %i\n-\tStarting Date: %@",t, s, self.fullname, self.number, self.startingDate];
    return s2;
}

@end
