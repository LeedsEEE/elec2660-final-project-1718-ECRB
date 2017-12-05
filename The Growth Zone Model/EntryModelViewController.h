//
//  EntryModelViewController.h
//  The Growth Zone Model
//
//  Created by Edward Baker on 04/12/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface EntryModelViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *pan;

@property (strong, nonatomic) NSString *subjectID;
@property (strong, nonatomic) NSString *entryID;

@property (strong, nonatomic) NSMutableDictionary *entry;

@property (strong, nonatomic) NSArray *modelArray;

@property (strong, nonatomic) IBOutlet UIView *frame;

@property (strong, nonatomic) DataModel *data;

@property int anxietyArea;
@property int growthArea;
@property int comfortArea;

@property float width;

@end
