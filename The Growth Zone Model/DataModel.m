//
//  DataModel.m
//  The Growth Zone Model
//
//  Created by Edward Baker [el16ecrb] on 23/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.subjects = [NSMutableArray array];
        
        Subject *testSubject = [[Subject alloc] init];
        testSubject.title = @"Test";
        testSubject.startDate = [NSDate date];
        testSubject.finishDate = [NSDate date];
        
        [self.subjects addObject:testSubject];  // Create a test subject
        
    }
    return self;
}

@end
