//
//  ProgressGraphViewController.h
//  The Growth Zone Model
//
//  Created by Edward Baker on 01/12/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface ProgressGraphViewController : UIViewController

#pragma mark - Classes

@property (strong, nonatomic) DataModel *data;

#pragma mark - Objects

@property (strong, nonatomic) NSMutableDictionary *entrys;

@property (strong, nonatomic) NSArray *sortedKeys;
@property (strong, nonatomic) NSArray *graphArray;
@property (strong, nonatomic) NSString *subjectID;

#pragma mark - Values

@property int border;

@end
