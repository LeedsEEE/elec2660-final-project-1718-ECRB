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

@property (strong, nonatomic) NSString *subjectID;
@property (strong, nonatomic) NSArray *graphArray;

@property (strong, nonatomic) NSMutableDictionary *entrys;

@property (strong, nonatomic) NSArray *sortedKeys;

@property (strong, nonatomic) DataModel *data;

@property int border;

@end
