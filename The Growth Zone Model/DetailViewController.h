//
//  DetailViewController.h
//  The Growth Zone Model
//
//  Created by Edward Baker [el16ecrb] on 21/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subject.h"
#import "Date.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationItem *subjectNavigation;

@property (weak, nonatomic) IBOutlet UILabel *LBDates;
@property (weak, nonatomic) IBOutlet UILabel *LBPastEntries;

@property (weak, nonatomic) IBOutlet UIButton *BTCreateEntry;

@property (weak, nonatomic) IBOutlet UIView *TBPastEntries; //Unsure if Needed

@property (strong, nonatomic) Subject *subject;

@property (strong, nonatomic) Date *date;

@end
