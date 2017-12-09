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
#import "EntryViewController.h"
#import <GLKit/GLKit.h>

@class EntryTableViewController;
@class EntryViewController;

@interface DetailViewController : UIViewController

#pragma mark - View Controllers

@property (strong, nonatomic) EntryTableViewController *entryTableViewController;
@property (strong, nonatomic) EntryViewController *entryViewController;

#pragma mark - Classes

@property (strong, nonatomic) Date *date;
@property (strong, nonatomic) DataModel *data;

#pragma mark - UIObjects

@property (weak, nonatomic) IBOutlet UINavigationItem *subjectNavigation;

@property (weak, nonatomic) IBOutlet UIView *progressGraph;
@property (weak, nonatomic) IBOutlet UIView *TBPastEntries;
@property (weak, nonatomic) IBOutlet UIView *overlayView;

@property (weak, nonatomic) IBOutlet UILabel *LBDates;
@property (weak, nonatomic) IBOutlet UILabel *LBPastEntries;
@property (weak, nonatomic) IBOutlet UILabel *noSubject;

@property (weak, nonatomic) IBOutlet UIButton *BTCreateEntry;

#pragma mark - Objects

@property (strong, nonatomic) NSMutableDictionary *subject;
@property (strong, nonatomic) NSString *subjectID;

@end
