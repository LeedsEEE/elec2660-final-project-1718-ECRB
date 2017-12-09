//
//  DataModel.h
//  The Growth Zone Model
//
//  Created by Edward Baker [el16ecrb] on 23/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Date.h"

@interface DataModel : NSObject

#pragma mark - Classes

@property (strong, nonatomic) Date *date;

#pragma mark - Objects

@property (strong, nonatomic) NSMutableDictionary *subjects;
@property (strong, nonatomic) NSMutableDictionary *subjectTemplate;
@property (strong, nonatomic) NSMutableDictionary *entryTemplate;

@property (strong, nonatomic) NSString *filePath;

#pragma mark - Methods

- (void)save:(NSMutableDictionary *)dict;
- (NSMutableDictionary *)load;

@end
