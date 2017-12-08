//
//  DataModel.m
//  The Growth Zone Model
//
//  Created by Edward Baker [el16ecrb] on 23/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

#pragma mark - Initialise

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.subjectTemplate = [[NSMutableDictionary alloc] init];        // Creates a template for subjects
        NSMutableDictionary *entrys = [[NSMutableDictionary alloc] init]; //
        self.subjectTemplate[@"entrys"] = entrys;                         //
        self.subjectTemplate[@"startDate"] = @"StartDate";                //
        self.subjectTemplate[@"finishDate"] = @"FinishDate";              //
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); // Creates an array of paths for the local domains
        self.filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Data.out"];             // appens the file name to the first object in the array
                                                                                                          // to find the saving filepath
        self.subjects = [self load]; // Load in the data from the file at the filepath
        
        if(!self.subjects) // If the file has loaded null
        {
            self.subjects = [[NSMutableDictionary alloc] init];       // Create the subject dictionary
            NSMutableArray *keyArray = [[NSMutableArray alloc] init]; // Initialise the keyArray
            self.subjects[@"keyArray"] = keyArray;                    // Add the keyArray to the dictionary
            [self save:self.subjects];                                // Save as the file at the filepath
        }
    }
    return self;
}

# pragma mark - File handling

- (void)save:(NSMutableDictionary *)dict // Writes the dictionary passed to the file at the path self.filepath
{
    [dict writeToFile:self.filePath atomically:YES];
}

- (NSMutableDictionary *)load // Returns a dictionary with the contents of the file at self.filepath (null if no file found)
{
    return [NSMutableDictionary dictionaryWithContentsOfFile:self.filePath];
}
@end
