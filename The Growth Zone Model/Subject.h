//
//  SubjectData.h
//  The Growth Zone Model
//
//  Created by Edward Baker [el16ecrb] on 21/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entry.h"

@interface Subject : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *finishDate;
@property NSMutableArray *progressGraph;

@property (strong, nonatomic) NSMutableArray *entrys;

@end
