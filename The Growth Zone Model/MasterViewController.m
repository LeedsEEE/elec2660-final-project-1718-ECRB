//
//  MasterViewController.m
//  The Growth Zone Model
//
//  Created by Edward Baker [el16ecrb] on 21/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

#pragma mark - View Loading

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [[DataModel alloc] init]; // Initialise DataModel
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;                       // Sets the left button on the master view to edit the table
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self action:@selector(insertNewObject:)];     // Creates a button, addButton, that calls insertnewobject when pressed
    self.navigationItem.rightBarButtonItem = addButton;                                // Sets the right button on the master view to be addButton
    
    self.detailViewController =
    (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController]; // Sets the detailViewController property of the master view
                                                                                                       // to the view controller at the top of the stack in the last object
                                                                                                       // in the array of viewcontroller managed by the splitviewcontroller
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed; //Clears the subject table selection when the splitviewcontroller is collapsed
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // As my app is not memory heavy there is no code here
    // But the method is kept incase of future modifications that would require it
}

#pragma mark - New Subject

- (void)insertNewObject:(id)sender { // This method is called when the plus button above the subject table is pressed
    
    UIAlertController *popUp = [UIAlertController alertControllerWithTitle:@"New Subject"   // Creates a popup *popup with title "New Subject"
    message:@"Please enter your subject title" preferredStyle:UIAlertControllerStyleAlert]; // with a message "Please enter your subject title"
                                                                                            // and in the style of an Alert (standard type)
    
    [popUp addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull subjectTitle){      // Adds a text field to the popup
        subjectTitle.placeholder = @"Subject Title"; }];                                    // with the placeholder "Subject Title"
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" // Creates an Alert action (button) in the style cancel
    style:UIAlertActionStyleCancel handler:nil];                     // which closes the parent popup when its pressed
    
    [popUp addAction:cancel];                                        // Adds the action cancel to the popup *popup
    
    UIAlertAction *create = [UIAlertAction actionWithTitle:@"Create Subject"                                // Creates an Alert action in the style destructive
                            style:UIAlertActionStyleDestructive handler:^(UIAlertAction *subjectCreated){   // similar to cancel, but its handler calls the
                                                                                                            // following block when pressed
                                
        NSString *subjectName = [[popUp textFields][0] text]; // Creates a temporary NSString with the text from the texfield created before
        
        if ([self.data.subjects[@"keyArray"] containsObject:subjectName]){ // Checks if the entered subject title is already in use
            
            UIAlertController *invalidTitle = [UIAlertController alertControllerWithTitle:@"Warning"          // Creates a popup with title "Warning"
            message:@"You cannot have two subjects with the same title\nPlease use a different subject title" // and message (see left)
                                                                preferredStyle:UIAlertControllerStyleAlert];  // of type Alert (standard type)
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:nil]; // Creates Destructive alert action with title "OK"
            
            [invalidTitle addAction:ok]; // Adds *ok to the popup
            
            [self presentViewController:invalidTitle animated:YES completion:nil]; // Present the popup
            
        } else {
            
            self.data.subjects = [self.data load]; // Load subject dictionary
            
            self.data.subjects[subjectName] = [self.data.subjectTemplate mutableCopy]; // Create a blank template for the subject
            
            [self.data.subjects[@"keyArray"] insertObject:subjectName atIndex:0]; // Insert the subject key into the start of the key array
            
            [self.data save:self.data.subjects]; // Save the new subject
            
            [self.tableView reloadData]; // Reload the table view
            [self viewDidLoad]; // Reload the view
            
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop]; // Select the new subject in the table
            
            [self performSegueWithIdentifier:@"showDetail" sender:self]; // Force a segue to set the detail view controller to the current subject
        }
        
    }];
    
    [popUp addAction:create]; // Add the create subject button to the popup
    
    [self presentViewController:popUp animated:YES completion:nil]; // Show the popup

}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { // Sets the number of sections in the table to be 1
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { // Sets the number of rows to be the amount of subjects
    return (self.data.subjects.count - 1);                                                 // One item in the dictionary is the keyarray, hence the - 1
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {         // Returns the key at the index of the current row
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubjectCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.data.subjects[@"keyArray"] objectAtIndex:indexPath.row];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath { // Lets all the Rows  be editiable
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath { // Method is called when the user
    if (editingStyle == UITableViewCellEditingStyleDelete) {                                                                                         // deletes a subject
        
        NSString *subjectKey = self.data.subjects[@"keyArray"][indexPath.row];                                   // Gets the subjects title
        NSString *warningMessage = [NSString stringWithFormat:@"Are you sure you want to delete %@",subjectKey]; // Creates the string to ask the user are they sure they want to delete x subject
        
        UIAlertController *deleteWarning = [UIAlertController alertControllerWithTitle:@"Warning" message:warningMessage preferredStyle:UIAlertControllerStyleAlert]; // Creates the delete alert
        
        UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *objectDeleted){ // Creates the Alert action *yes
            // Block runs if yes is selected
            
            [self.data.subjects removeObjectForKey:subjectKey];                  // Removes subject from dictionary (data)
            [self.data.subjects[@"keyArray"] removeObjectAtIndex:indexPath.row]; // Removes subject from keyArray
            
            [self.data save:self.data.subjects]; // Saves the changes in data
            [self.tableView reloadData];         // Reloads the table
            [self viewDidLoad];                  // Reloads the view
            
            if (self.detailViewController.subjectID == subjectKey){ // If the current selection is the subject to be deleted
                self.detailViewController.subjectID = NULL;         // Change the selection to null
                [self.detailViewController viewDidLoad];            // Reload the detail view
            }
        }];
        
        [deleteWarning addAction:yes]; // Add the delete action to the popup
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]; // Create a cancel action, this will close the popup without deleting the subject
        [deleteWarning addAction:cancel];                                                                             // Add the cancel action to the popup
        
        [self presentViewController:deleteWarning animated:YES completion:nil]; // Show the popup
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) { // Code left for future use incase more handling of inserting objects is needed
        
    }
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender { // Method is called before any segue occurs
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) { // If the segue is to show the detail view controller
        
        DetailViewController *detailViewController = (DetailViewController *)[[segue destinationViewController] topViewController]; // Create a local object of type DetailViewController
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow]; // Finds the index path for the selected row in the table
        
        detailViewController.subjectID = [self.data.subjects[@"keyArray"] objectAtIndex:indexPath.row]; // Sets the subject of the detailview controller to be the one seleted
        
        detailViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem; // Creates the split view controller show in the detail view controller
        detailViewController.navigationItem.leftItemsSupplementBackButton = YES;                                // This sets the button to supplement the back button rather than replace it
    }
}


@end
