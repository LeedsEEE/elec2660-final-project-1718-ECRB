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

    
    
    if (self.entry) { //Input saved entry data to UI
        self.title = [self.date.dateFormatter stringFromDate:self.entry.date]; //Set title to relevant Entry date
        self.TVNote.text = self.entry.note;                                    //Set text field to relevant entry data
        self.LBComfortPercentage.text = [NSString stringWithFormat:@"%d%%", self.entry.comfortArea]; //Format and set the
        self.LBGrowthPercentage.text = [NSString stringWithFormat:@"%d%%", self.entry.growthArea];   //percentages to the
        self.LBAnxietyPercentage.text = [NSString stringWithFormat:@"%d%%", self.entry.anxietyArea]; //relevant entry data
        
    } else { // Set up data for a new entry
        
        self.title = @"New Entry";
    }
    
    // UI CONFIGURATION
    self.VComfort.layer.borderWidth = 2.0f; //Set Borders around UI objects
    self.VGrowth.layer.borderWidth = 2.0f;  //
    self.VAnxiety.layer.borderWidth = 2.0f; //
    self.VNote.layer.borderWidth = 2.0f;    //

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(id)sender {
    if(self.entry){
        self.entry.note = self.TVNote.text;
    }
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
