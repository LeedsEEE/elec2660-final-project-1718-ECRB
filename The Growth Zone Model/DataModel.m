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
        
        self.filePath = @"Data.json";
        
        self.subjects = [self load];
        
        NSMutableDictionary *tempSubject = [[NSMutableDictionary alloc] init];
        
        NSMutableDictionary *entrys = [[NSMutableDictionary alloc] init];
        
        NSMutableDictionary *tempEntry = [[NSMutableDictionary alloc] init];
        
        tempEntry[@"title"] = @"EntryTitle";
        tempEntry[@"note"] = @"This is a note";
        tempEntry[@"anxietyArea"] = @(10);
        
        entrys[@"EntryID"] = tempEntry;
        
        tempSubject[@"entrys"] = entrys;
        tempSubject[@"title"] = @"Test";
        tempSubject[@"startDate"] = @"StartDate";
        tempSubject[@"finishDate"] = @"FinishDate";
        
        self.subjects[@"testSubject"] = tempSubject;  // Create a test subject
        
        [self save:self.subjects];
        
    }
    return self;
}

- (void)save:(NSMutableDictionary *)dict
{
    
    NSData *json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    
    NSLog(@"Trying");
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.filePath]) { //If there is no json file, create one
        [[NSFileManager defaultManager] createFileAtPath:self.filePath contents:nil attributes:nil];
    }
    
    [json writeToFile:self.filePath atomically:NO];
    
}

- (NSMutableDictionary *)load
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.filePath]) {
        NSData *json = [[NSData alloc] initWithData:[NSData dataWithContentsOfFile:self.filePath]];
        NSMutableDictionary *tempdict = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
        if (tempdict){
            dict = tempdict;
        }
    }
    return dict;
}
@end
