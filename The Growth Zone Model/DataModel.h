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

@interface DataModel : NSObject

@property (strong, nonatomic) NSMutableDictionary *subjects;
@property (strong, nonatomic) NSData *json;

@property (strong, nonatomic) NSString *filePath;



@end
