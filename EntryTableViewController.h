//
//  EntryTableViewController.h
//  The Growth Zone Model
//
//  Created by Edward Baker on 24/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subject.h"
#import "EntryViewController.h"
#import "Date.h"
#import "DetailViewController.h"

@interface EntryTableViewController : UITableViewController

@property (strong, nonatomic) Subject *data;
@property (strong, nonatomic) Date *date;

@end
