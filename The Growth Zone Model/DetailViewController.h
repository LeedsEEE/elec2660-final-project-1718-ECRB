//
//  DetailViewController.h
//  The Growth Zone Model
//
//  Created by Edward Baker [el16ecrb] on 21/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Date.h"
#import "DataModel.h"
#import "EntryTableViewController.h"
#import <GLKit/GLKit.h>

@class EntryTableViewController;

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *subjectNavigation;
@property (weak, nonatomic) IBOutlet UIView *progressGraph;

@property (weak, nonatomic) IBOutlet UILabel *LBDates;
@property (weak, nonatomic) IBOutlet UILabel *LBPastEntries;
@property (weak, nonatomic) IBOutlet UILabel *noSubject;
@property (weak, nonatomic) IBOutlet UIView *overlayView;

@property (weak, nonatomic) IBOutlet UIButton *BTCreateEntry;

@property (weak, nonatomic) IBOutlet UIView *TBPastEntries; //Unsure if Needed

@property (strong, nonatomic) NSMutableDictionary *subject;

@property (strong, nonatomic) NSString *subjectID;

@property (strong, nonatomic) Date *date;

@property (strong, nonatomic) DataModel *data;

@property (strong, nonatomic) EntryTableViewController *entryTableViewController;

@end
