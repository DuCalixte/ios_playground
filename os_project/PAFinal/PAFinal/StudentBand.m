//
//  StudentBand.m
//  PAFinal
//
//  Created by STANLEY CALIXTE on 3/9/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "StudentBand.h"

@implementation StudentBand

-(id)init
{
    return [self initWithName:nil
                    andNumber:0
            andInstrument:nil];
}

-(id)initWithName:(NSString *)name andNumber:(int)number andInstrument:(NSString *)inst
{
    self = [super initWithName:name
                     andNumber:number];
    if (self) {
        self.instrument = inst;
    }
    return self;
}

-(id)initWithName:(NSString *)name andNumber:(int)number andInstrument:(NSString *)inst andDate:(NSDate *)date
{
    self = [super initWithName:name
                     andNumber:number andDate:date];
    if (self) {
        self.instrument = inst;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //[aCoder encodeObject:self.fullname forKey:KEY_NAME];
    //[aCoder encodeInt:self.number forKey:KEY_NUMBER];
    //[aCoder encodeObject:self.startingDate forKey:KEY_DATE];
    
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.instrument forKey:KEY_INSTRUMENT];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super init])
    {
        self.fullname = [aDecoder decodeObjectForKey:KEY_NAME];
        self.number = [aDecoder decodeIntForKey:KEY_NUMBER];
        self.startingDate = [aDecoder decodeObjectForKey:KEY_DATE];
        
        self.instrument = [aDecoder decodeObjectForKey:KEY_INSTRUMENT];
    }
    
    return self;
}

-(NSString *)description
{
    return [NSString
            stringWithFormat:@"%@\n-\tInstrument: %@",
            [super description],
            self.instrument];
    
}

@end
