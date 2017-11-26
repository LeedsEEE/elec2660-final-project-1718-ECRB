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

@property (strong, nonatomic) Entry *entry;

@property (strong, nonatomic) Date *date;

@end
