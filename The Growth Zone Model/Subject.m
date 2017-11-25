//
//  SubjectData.m
//  The Growth Zone Model
//
//  Created by Edward Baker [el16ecrb] on 21/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import "Subject.h"

@implementation Subject

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.entrys = [NSMutableArray array];
        
        Entry *testEntry = [[Entry alloc] init];
        testEntry.date = [NSDate date];
        
        [self.entrys addObject:testEntry]; // Create a test entry
        
    }
    return self;
}

@end
