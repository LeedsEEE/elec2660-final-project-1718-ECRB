//
//  Date.m
//  The Growth Zone Model
//
//  Created by Edward Baker on 24/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import "Date.h"

@implementation Date

# pragma mark - Initialisation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        
        self.dateFormatter.dateStyle = NSDateFormatterShortStyle; //Short date style
        self.dateFormatter.timeStyle = NSDateFormatterNoStyle;    //No time data
        
        self.dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"]; //Use the english date format
        [self.dateFormatter setLocalizedDateFormatFromTemplate:@"yMd"];                   //Set the date to day month year
        
    }
    return self;
}

@end
