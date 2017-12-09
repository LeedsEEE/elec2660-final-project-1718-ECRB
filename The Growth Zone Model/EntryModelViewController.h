//
//  EntryModelViewController.h
//  The Growth Zone Model
//
//  Created by Edward Baker on 04/12/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import "EntryViewController.h"

@class EntryViewController;

@interface EntryModelViewController : UIViewController

#pragma mark - ViewControllers

@property (strong, nonatomic) EntryViewController *entryViewController;

#pragma mark - Classes

@property (strong, nonatomic) DataModel *data;

#pragma mark - UIObjects

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *pan;

@property (strong, nonatomic) IBOutlet UIView *frame;

#pragma mark - Objects

@property (strong, nonatomic) NSString *subjectID;
@property (strong, nonatomic) NSString *entryID;
@property (strong, nonatomic) NSString *selected;

@property (strong, nonatomic) NSMutableDictionary *entry;

@property (strong, nonatomic) NSArray *modelArray;

#pragma mark - Values

@property int anxietyArea;
@property int growthArea;
@property int comfortArea;

@property float anxietyRadius;
@property float growthRadius;
@property float comfortRadius;

@property float width;
@property float radiusMultiplier;

@property float tolerance;

@end
