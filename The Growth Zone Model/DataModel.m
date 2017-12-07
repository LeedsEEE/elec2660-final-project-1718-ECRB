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
        
        self.date = [[Date alloc] init];
        
        self.subjectTemplate = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *entrys = [[NSMutableDictionary alloc] init];
        self.subjectTemplate[@"entrys"] = entrys;
        self.subjectTemplate[@"startDate"] = @"StartDate";
        self.subjectTemplate[@"finishDate"] = @"FinishDate";
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Data.out"];

        self.subjects = [self load];
        
        if(!self.subjects)
        {
            self.subjects = [[NSMutableDictionary alloc] init];
            NSMutableArray *keyArray = [[NSMutableArray alloc] init];
            //[keyArray addObject:@"tempp"];
            self.subjects[@"keyArray"] = keyArray;
            //self.subjects[@"temp"] = [self.subjectTemplate mutableCopy];
            [self save:self.subjects];
            //NSLog(@"%@",self.subjects);
            //NSLog(@"%@",[self load]);
        }
        
        if ([self.subjects count] == 0)
        {
            /*
            NSMutableDictionary *tempSubject = [[NSMutableDictionary alloc] init];
        
            NSMutableDictionary *entrys = [[NSMutableDictionary alloc] init];
        
            NSMutableDictionary *tempEntry = [[NSMutableDictionary alloc] init];
        
            tempEntry[@"title"] = @"EntryTitle";
            tempEntry[@"note"] = @"This is a note";
            tempEntry[@"comfortArea"] = @(40);
            tempEntry[@"growthArea"] = @(20);
            tempEntry[@"anxietyArea"] = @(10);
            
            NSString *tempID = [self.date.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:100]];
            
            NSMutableDictionary *temp2Entry = [[NSMutableDictionary alloc] init];
            
            tempEntry[@"title"] = @"EntryTitle";
            tempEntry[@"note"] = @"This is a note";
            tempEntry[@"comfortArea"] = @(50);
            tempEntry[@"growthArea"] = @(30);
            tempEntry[@"anxietyArea"] = @(20);
            
            NSString *tempID2 = [self.date.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:100]];
            
            NSMutableDictionary *temp3Entry = [[NSMutableDictionary alloc] init];
            
            tempEntry[@"title"] = @"EntryTitle";
            tempEntry[@"note"] = @"This is a note";
            tempEntry[@"comfortArea"] = @(70);
            tempEntry[@"growthArea"] = @(50);
            tempEntry[@"anxietyArea"] = @(20);
            
            NSString *tempID3 = [self.date.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:100]];
        
            entrys[tempID] = tempEntry;
            entrys[tempID2] = temp2Entry;
            entrys[tempID3] = temp3Entry;
        
            tempSubject[@"entrys"] = entrys;
            tempSubject[@"startDate"] = @"StartDate";
            tempSubject[@"finishDate"] = @"FinishDate";
        
            self.subjects[@"testSubject"] = tempSubject;  // Create a test subject
            
            NSMutableArray *keyArray = [[NSMutableArray alloc] init];
            [keyArray addObject:@"testSubject"];
            
            self.subjects[@"keyArray"] = keyArray;
        
            [self save:self.subjects];
             */
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
