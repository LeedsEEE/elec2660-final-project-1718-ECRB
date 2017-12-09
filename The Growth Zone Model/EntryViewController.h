//
//  EntryViewController.h
//  The Growth Zone Model
//
//  Created by Edward Baker on 24/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Date.h"
#import "DataModel.h"
#import "EntryModelViewController.h"

@class EntryModelViewController;

@interface EntryViewController : UIViewController

#pragma mark - View Controllers

@property (strong, nonatomic) EntryModelViewController *entryModelViewController;

#pragma mark - Classes

@property (strong, nonatomic) Date *date;
@property (strong, nonatomic) DataModel *data;

#pragma mark - UIObjects

@property (weak, nonatomic) IBOutlet UIBarButtonItem *BTSave;

@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@property (weak, nonatomic) IBOutlet UIView *frame;

@property (weak, nonatomic) IBOutlet UIStackView *SVRight;

@property (weak, nonatomic) IBOutlet UIView *VComfort;
@property (weak, nonatomic) IBOutlet UIStackView *SVComfort;
@property (weak, nonatomic) IBOutlet UILabel *LBComfortPercentage;
@property (weak, nonatomic) IBOutlet UILabel *LBComfort;

@property (weak, nonatomic) IBOutlet UIView *VGrowth;
@property (weak, nonatomic) IBOutlet UIStackView *SVGrowth;
@property (weak, nonatomic) IBOutlet UILabel *LBGrowthPercentage;
@property (weak, nonatomic) IBOutlet UILabel *LBGrowth;

@property (weak, nonatomic) IBOutlet UIView *VAnxiety;
@property (weak, nonatomic) IBOutlet UIStackView *SVAnxiety;
@property (weak, nonatomic) IBOutlet UILabel *LBAnxietyPercentage;
@property (weak, nonatomic) IBOutlet UILabel *LBAnxiety;

@property (weak, nonatomic) IBOutlet UIView *VNote;
@property (weak, nonatomic) IBOutlet UIStackView *SVNote;
@property (weak, nonatomic) IBOutlet UITextView *TVNote;

#pragma mark - Objects

@property (strong, nonatomic) NSMutableDictionary *entry;

@property (strong, nonatomic) NSString *subjectID;
@property (strong, nonatomic) NSString *entryID;

#pragma mark - Values

@property int frameWidth;

#pragma mark - Methods

- (void)updateLabels_comfort:(int)comfort growth:(int)growth anxiety:(int)anxiety;

@end
