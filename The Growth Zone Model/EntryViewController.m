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
        
        self.entry[@"anxietyArea"] = [[NSNumber alloc] initWithInt:27];  // Sets the starting values for the area labels
        self.entry[@"growthArea"] = [[NSNumber alloc] initWithInt:18];   // these are used if no values can be found
        self.entry[@"comfortArea"] = [[NSNumber alloc] initWithInt:19];  //
        
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
    
    self.entry[@"note"] = self.TVNote.text; // Gets the text within the note
    
    if(!self.entryID){
        
        NSDate *tempDate = [NSDate date]; // Finds the current Date
        
        NSString *dateString = [self.date.dateFormatter stringFromDate:tempDate]; // Takes the date and converts it to a string
        
        self.entry[@"date"] = dateString; // Assigns the dateString to the entry
        
        int suffix = 1; // Initialised the iteration counter
        
        NSArray *getkeys = [self.data.subjects[self.subjectID][@"entrys"] allKeys]; // Gets an array of all the entry keys
        NSString *tempID = [NSString stringWithFormat:@"%@",dateString];            // Creates a temporary entry key to test
        
        while([getkeys containsObject:tempID]) // Checks if the entry key is already in use, if it is then incrememnt the suffix
        {
            tempID = [NSString stringWithFormat:@"%@_%d",dateString,suffix];
            suffix++;
        }
        self.entryID = tempID; // Set the entryKey to the temp key
    }

    self.data.subjects[self.subjectID][@"entrys"][self.entryID] = self.entry; // Add the entry to the rest of the data
    [self.data save:self.data.subjects];                                      // Saves the new data
    [[self navigationController] popViewControllerAnimated:YES];              // Go back to the subject view
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"embed"]) {

        
        EntryModelViewController *entryModelViewController = [segue destinationViewController];
        
        self.entryModelViewController = entryModelViewController;      //
                                                                       // Sets the property of entryModelViewController to be the viewcontroller
        entryModelViewController.subjectID = self.subjectID;           // that is being segued too
        entryModelViewController.entryID = self.entryID;               // sets the correct subject and entry key
        
        entryModelViewController.entryViewController = self;           // makes sure the modelviewcontroller has its parent as a property to pass data
        
        float tempWidth = self.view.bounds.size.width - 310;                                                        // Finds the size of the modelviewcontroller
        float tempHeight = self.view.bounds.size.height - self.navigationController.navigationBar.frame.size.height // using the set constraints and sizes of
        - UIApplication.sharedApplication.statusBarFrame.size.height - 50;                                          // views and bars
        
        if (tempWidth < tempHeight){
            entryModelViewController.width = tempWidth;  // The view will be set to the largest square possible, so only
        } else {                                         // The smallest value from the possible width and height is needed
            entryModelViewController.width = tempHeight; //
        }
        
    }
}

/*

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
