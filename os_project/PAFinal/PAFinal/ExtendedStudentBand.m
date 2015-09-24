//
//  ExtendedStudentBand.m
//  PAFinal
//
//  Created by STANLEY CALIXTE on 3/9/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "ExtendedStudentBand.h"

@implementation ExtendedStudentBand

-(id)init
{
    return [self initWithName:nil andNumber:0 andInstrument:nil andDate:nil andCity:nil andState:nil andCountry:nil];
}

-(id)initWithName:(NSString *)name andNumber:(int)number andInstrument:(NSString *)inst andCity: (NSString *)city andCountry:(NSString *)country
{
    self = [super initWithName:name
                     andNumber:number
                 andInstrument:inst];
    
    if (self) {
        self.city = city;
        self.country = country;
    }
    
    return self;
}

-(id)initWithName:(NSString *)name andNumber:(int)number andInstrument:(NSString *)inst andDate:(NSDate *)date andCity: (NSString *)city andCountry:(NSString *)country
{
    self = [super initWithName:name
                     andNumber:number
                 andInstrument:inst
            andDate:date];
    
    if (self) {
        self.city = city;
        self.country = country;
    }
    
    return self;
}

-(id)initWithName:(NSString *)name andNumber:(int)number andInstrument:(NSString *)inst andCity: (NSString *)city andState:(NSString *)state andCountry:(NSString *)country
{
    self = [super initWithName:name
                     andNumber:number
                 andInstrument:inst];
    
    if (self) {
        self.city = city;
        self.state = state;
        self.country = country;
    }
    
    return self;
}

-(id)initWithName:(NSString *)name andNumber:(int)number andInstrument:(NSString *)inst andDate:(NSDate *)date andCity: (NSString *)city andState:(NSString *)state andCountry:(NSString *)country
{
    self = [super initWithName:name
                     andNumber:number
                 andInstrument:inst
                       andDate:date];
    
    if (self) {
        self.city = city;
        self.state = state;
        self.country = country;
    }
    
    return self;
}

+(id)extendedStudentBandWithName:(NSString *)name
                       andNumber:(int)number andInstrument:(NSString *)inst andDate:(NSDate *)date andCity: (NSString *)city andState:(NSString *)state andCountry:(NSString *)country
{
    return [[ExtendedStudentBand alloc] initWithName:name andNumber:number andInstrument:inst andDate:date andCity:city andState:state andCountry:country];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //[aCoder encodeObject:self.fullname forKey:KEY_NAME];
    //[aCoder encodeInt:self.number forKey:KEY_NUMBER];
    //[aCoder encodeObject:self.startingDate forKey:KEY_DATE];
    
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.instrument forKey:KEY_INSTRUMENT];
    
    [aCoder encodeObject:self.city forKey:KEY_CITY];
    [aCoder encodeObject:self.state forKey:KEY_STATE];
    [aCoder encodeObject:self.country forKey:KEY_COUNTRY];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super init])
    {
        self.fullname = [aDecoder decodeObjectForKey:KEY_NAME];
        self.number = [aDecoder decodeIntForKey:KEY_NUMBER];
        self.startingDate = [aDecoder decodeObjectForKey:KEY_DATE];
        
        self.instrument = [aDecoder decodeObjectForKey:KEY_INSTRUMENT];
        
        self.city = [aDecoder decodeObjectForKey:KEY_CITY];
        self.state = [aDecoder decodeObjectForKey:KEY_STATE];
        self.country = [aDecoder decodeObjectForKey:KEY_COUNTRY];
    }
    
    return self;
}

-(NSString *)description
{
    return [NSString
            stringWithFormat:@"%@\n-\tCity: %@%@\n-\tCountry: %@",
            [super description],
            self.city,
            self.state? [NSString stringWithFormat:@"\n-\tState: %@",self.state]:@"",
            self.country];
}

@end
