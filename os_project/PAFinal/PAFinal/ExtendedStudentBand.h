//
//  ExtendedStudentBand.h
//  PAFinal
//
//  Created by STANLEY CALIXTE on 3/9/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "StudentBand.h"

#define KEY_CITY @"KeyCity"
#define KEY_STATE @"KeyState"
#define KEY_COUNTRY @"KeyCountry"


@interface ExtendedStudentBand : StudentBand

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *country;


-(id)init;
-(id)initWithName:(NSString *)name andNumber:(int)number andInstrument:(NSString *)inst andCity: (NSString *)city andCountry:(NSString *)country;
-(id)initWithName:(NSString *)name andNumber:(int)number andInstrument:(NSString *)inst andDate:(NSDate *)date andCity: (NSString *)city andCountry:(NSString *)country;

-(id)initWithName:(NSString *)name andNumber:(int)number andInstrument:(NSString *)inst andCity: (NSString *)city andState:(NSString *)state andCountry:(NSString *)country;
-(id)initWithName:(NSString *)name andNumber:(int)number andInstrument:(NSString *)inst andDate:(NSDate *)date andCity: (NSString *)city andState:(NSString *)state andCountry:(NSString *)country;

+(id)extendedStudentBandWithName:(NSString *)name
           andNumber:(int)number andInstrument:(NSString *)inst andDate:(NSDate *)date andCity: (NSString *)city andState:(NSString *)state andCountry:(NSString *)country;

- (void)encodeWithCoder:(NSCoder *)aCoder;
-(NSString *)description;

@end
