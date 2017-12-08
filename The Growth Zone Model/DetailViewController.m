//
//  DetailViewController.m
//  The Growth Zone Model
//
//  Created by Edward Baker [el16ecrb] on 21/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Loading and Configuration

- (void)configureView {

    self.data = [[DataModel alloc] init]; // Initialise the DataModel
    self.date = [[Date alloc] init];      // Initialise local DateFormatter
    
    self.BTCreateEntry.layer.cornerRadius = 10.0f;                        // Create borders and colours
    self.TBPastEntries.layer.borderColor = [[UIColor grayColor]CGColor];  // for aesthetics
    self.TBPastEntries.layer.borderWidth = 2.0f;                          //
    self.progressGraph.layer.borderWidth = 2.0f;                          //

    if (self.subjectID) { // Checks if a subject is selected
        
        self.view.userInteractionEnabled = YES; // Enable the user to interact with the view
        
        self.subject = self.data.subjects[self.subjectID]; // Sets self.subject to be the correct data
        
        self.title = self.subjectID; // Sets the title
        
        NSArray *sortedKeys = [[self.data.subjects[self.subjectID][@"entrys"] allKeys] sortedArrayUsingComparator:^NSComparisonResult(id a, id b) { // Sorts the entry keys
            if (([a length] != [b length]) && ([a substringToIndex:9] == [b substringToIndex:9])) {                                                 // Based on the date
                return [[NSNumber numberWithInteger:[a length]] compare:[NSNumber numberWithInteger:[b length]]];                                   // and the iteration number
            } else {
                return [a compare:b];
        }}];
        
        if(sortedKeys.count){ // If there are any entrys
            self.LBDates.text = [NSString stringWithFormat:@"%@ - %@",                          // Remove any iteration on the dates
            [[sortedKeys lastObject]substringToIndex:10], [sortedKeys[0] substringToIndex:10]]; // Set the label to be the first to last date
        } else {
            self.LBDates.text = @"No Entries"; // Set the label to no entries when there are no entries
        }
        
    } else { // No siubject is selected
        self.view.userInteractionEnabled = NO; // Stops user interacting with the view
        self.title = @"";                      // Clear title
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleProminent];   // Create a blur effect
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];  // Create an EffectView with the effect blur
        blurView.frame = self.view.bounds;                                                // Set the EffectView frame to the bounds of the detailview
        blurView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth; // Let the blur autosize
        
        self.overlayView.hidden = NO; // Set the overlay to visible, the overlay holds the "Please Select a Subject" label

        [self.view insertSubview:blurView atIndex:2]; // Insert the blur below the label
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureView]; // Reconfigures the view every time it appears, this lets the graph resize and update
}

/*
- (void)viewDidLoad {                   // Methods left for future use
    [super viewDidLoad];                //
}                                       //
                                        //
- (void)didReceiveMemoryWarning {       //
    [super didReceiveMemoryWarning];    //
}
*/
 
#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"showNewEntry"]) { // If the segue is creating a new entry
        
        self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden; //When you select an entry the master view is hidden
        
        self.entryViewController = [segue destinationViewController]; // Sets the self.entryviewcontroller to be the viewcontroller that is being segued to
        
        self.entryViewController.subjectID = self.subjectID; // Sets the correct subjectID for the new view controller
        
    } else if ([[segue identifier] isEqualToString:@"embed"]) { // If the segue is embedding the entry table
        
        self.entryTableViewController = [segue destinationViewController]; // Sets self.entryTableViewController to be the embbedded viewcontroller
        
        self.entryTableViewController.subjectID = self.subjectID; // Sets the correct subjectID for the table
        
    }
}

@end
