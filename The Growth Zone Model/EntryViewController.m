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
    self.data = [[DataModel alloc] init];
    
    if (self.entryID) { //Input saved entry data to UI
        
        self.entry = self.data.subjects[self.subjectID][@"entrys"][self.entryID];   //Create a new dictionary of the entry to shortern code
        
        self.title = self.entryID; //Set title to relevant Entry ID
        
        self.TVNote.text = self.entry[@"note"];                                    //Set text field to relevant entry data
        
        [self updateLabels_comfort:[self.entry[@"comfortArea"] intValue] growth:[self.entry[@"growthArea"] intValue] anxiety:[self.entry[@"anxietyArea"] intValue]];
        
    } else { // Set up data for a new entry
        
        self.entry = [[NSMutableDictionary alloc] init];
        
        self.title = @"New Entry";
        
    }
    
    // UI CONFIGURATION
    self.VComfort.layer.borderWidth = 2.0f; //Set Borders around UI objects
    self.VGrowth.layer.borderWidth = 2.0f;  //
    self.VAnxiety.layer.borderWidth = 2.0f; //
    self.VNote.layer.borderWidth = 2.0f;    //
    self.frame.layer.borderWidth = 2.0f;    //
}

- (void)updateLabels_comfort:(int)comfort growth:(int)growth anxiety:(int)anxiety {
    self.LBComfortPercentage.text = [NSString stringWithFormat:@"%d%%", comfort]; //Format and set the
    self.LBGrowthPercentage.text = [NSString stringWithFormat:@"%d%%", growth];   //percentages to the
    self.LBAnxietyPercentage.text = [NSString stringWithFormat:@"%d%%", anxiety]; //relevant entry data
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(id)sender {
    
    self.entry[@"note"] = self.TVNote.text;
    
    //self.entry[@"comfortArea"] = [[NSNumber alloc] initWithInt:self.entryModelViewController.comfortArea];
    //self.entry[@"growthArea"] = [[NSNumber alloc] initWithInt:self.entryModelViewController.growthArea];
    //self.entry[@"anxietyArea"] = [[NSNumber alloc] initWithInt:self.entryModelViewController.anxietyArea];
    
    if(!self.entryID){
        
        NSDate *tempDate = [NSDate date];
        
        NSString *dateString = [self.date.dateFormatter stringFromDate:tempDate];
        
        self.entry[@"date"] = dateString;
        
        int suffix = 1;
        
        NSArray *getkeys = [self.data.subjects[self.subjectID][@"entrys"] allKeys];
        NSString *tempID = [NSString stringWithFormat:@"%@",dateString];
        
        while([getkeys containsObject:tempID])
        {
            tempID = [NSString stringWithFormat:@"%@_%d",dateString,suffix];
            suffix++;
        }
        self.entryID = tempID;
    }

    self.data.subjects[self.subjectID][@"entrys"][self.entryID] = self.entry;
    [self.data save:self.data.subjects];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"embed"]) {

        
        EntryModelViewController *entryModelViewController = [segue destinationViewController];
        
        self.entryModelViewController = entryModelViewController;
        
        entryModelViewController.width = self.frame.bounds.size.width;
        
        entryModelViewController.subjectID = self.subjectID;
        entryModelViewController.entryID = self.entryID;
        
        entryModelViewController.entryViewController = self;
        
        float tempWidth = self.view.bounds.size.width - 310;
        float tempHeight = self.view.bounds.size.height - self.navigationController.navigationBar.frame.size.height - UIApplication.sharedApplication.statusBarFrame.size.height - 50;
        
        if (tempWidth < tempHeight){
            entryModelViewController.width = tempWidth;
        } else {
            entryModelViewController.width = tempHeight;
        }
        
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
