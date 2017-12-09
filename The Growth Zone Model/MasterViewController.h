//
//  MasterViewController.h
//  The Growth Zone Model
//
//  Created by Edward Baker [el16ecrb] on 21/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController

#pragma mark - ViewControllers

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) DataModel *data;

@end

