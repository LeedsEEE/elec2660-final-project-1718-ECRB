//
//  SubjectData.h
//  The Growth Zone Model
//
//  Created by Edward Baker [el16ecrb] on 21/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubjectData : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *finishDate;
@property NSInteger *progressGraph;
@property (strong, nonatomic) NSString *entryArray;

@end
