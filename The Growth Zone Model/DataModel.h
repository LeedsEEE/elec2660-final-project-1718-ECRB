//
//  DataModel.h
//  The Growth Zone Model
//
//  Created by Edward Baker [el16ecrb] on 23/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Subject.h"
#import "Entry.h"
#import "Date.h"

@interface DataModel : NSObject

@property (strong, nonatomic) NSMutableDictionary *subjects;
@property (strong, nonatomic) NSMutableDictionary *subjectTemplate;
@property (strong, nonatomic) NSMutableDictionary *entryTemplate;
@property (strong, nonatomic) Date *date;

@property (strong, nonatomic) NSString *filePath;

- (void)save:(NSMutableDictionary *)dict;
- (NSMutableDictionary *)load;

@end
