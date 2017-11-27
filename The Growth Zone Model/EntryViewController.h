//
//  EntryViewController.h
//  The Growth Zone Model
//
//  Created by Edward Baker on 24/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"
#import "Date.h"

@interface EntryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationBar *navigation;

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

@property (strong, nonatomic) Entry *entry;

@property (strong, nonatomic) Date *date;

@end
