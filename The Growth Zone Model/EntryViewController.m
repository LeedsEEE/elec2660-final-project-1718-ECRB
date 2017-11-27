//
//  EntryViewController.m
//  The Growth Zone Model
//
//  Created by Edward Baker on 24/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import "EntryViewController.h"

@interface EntryViewController ()

@end

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.date = [[Date alloc] init]; //Set the date of the entry as the current date
    
    self.VComfort.layer.borderWidth = 2.0f;
    self.VGrowth.layer.borderWidth = 2.0f;
    self.VAnxiety.layer.borderWidth = 2.0f;
    //self.TVNote.layer.borderWidth = 2.0f;
    self.VNote.layer.borderWidth = 2.0f;
    
    if (self.entry) {
        self.title = [self.date.dateFormatter stringFromDate:self.entry.date];
    } else {
        self.title = @"Test";
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
