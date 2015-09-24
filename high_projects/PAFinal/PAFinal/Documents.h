//
//  Documents.h
//  PAFinal
//
//  Created by STANLEY CALIXTE on 5/26/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Documents : NSManagedObject

@property (nonatomic, retain) NSString * contents;
@property (nonatomic, retain) NSDate * timeStamp;

@end
