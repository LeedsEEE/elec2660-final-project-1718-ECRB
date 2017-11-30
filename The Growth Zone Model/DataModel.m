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
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.date = [[Date alloc] init];
        
        self.filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Data.out"];
        
        self.subjects = [self load];
        
        if(!self.subjects)
        {
            self.subjects = [[NSMutableDictionary alloc] init];
        }
        
        if ([self.subjects count] == 0)
        {
            NSMutableDictionary *tempSubject = [[NSMutableDictionary alloc] init];
        
            NSMutableDictionary *entrys = [[NSMutableDictionary alloc] init];
        
            NSMutableDictionary *tempEntry = [[NSMutableDictionary alloc] init];
        
            tempEntry[@"title"] = @"EntryTitle";
            tempEntry[@"note"] = @"This is a note";
            tempEntry[@"anxietyArea"] = @(10);
            
            NSString *tempID = [self.date.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:100]];
            NSLog(@"%@",tempID);
            
        
            entrys[tempID] = tempEntry;
        
            tempSubject[@"entrys"] = entrys;
            tempSubject[@"title"] = @"Test";
            tempSubject[@"startDate"] = @"StartDate";
            tempSubject[@"finishDate"] = @"FinishDate";
        
            self.subjects[@"testSubject"] = tempSubject;  // Create a test subject
            
            NSMutableArray *keyArray = [[NSMutableArray alloc] init];
            [keyArray addObject:@"testSubject"];
            
            self.subjects[@"keyArray"] = keyArray;
        
            [self save:self.subjects];
        }
        
    }
    return self;
}

- (void)save:(NSMutableDictionary *)dict
{
    [dict writeToFile:self.filePath atomically:YES];
}

- (NSMutableDictionary *)load
{
    return [NSMutableDictionary dictionaryWithContentsOfFile:self.filePath];
}
@end
