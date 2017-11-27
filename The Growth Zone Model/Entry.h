//
//  EntryData.h
//  The Growth Zone Model
//
//  Created by Edward Baker [el16ecrb] on 21/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject

@property (strong, nonatomic) NSDate *date;

@property (strong, nonatomic) NSString *note;

@property int comfortArea;
@property int growthArea;
@property int anxietyArea;

@end
