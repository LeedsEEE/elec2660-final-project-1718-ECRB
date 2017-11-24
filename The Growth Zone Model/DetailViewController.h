//
//  DetailViewController.h
//  The Growth Zone Model
//
//  Created by Edward Baker [el16ecrb] on 21/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subject.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *finishDate;

@property (weak, nonatomic) IBOutlet UIButton *newEntry;
@property (weak, nonatomic) IBOutlet UITableView *pastEntries;

@property (strong, nonatomic) Subject *subject;


@end

