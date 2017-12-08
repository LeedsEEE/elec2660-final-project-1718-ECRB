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
    message:@"Please enter your subject title" preferredStyle:UIAlertControllerStyleAlert]; // with a message a"Please enter your subject title"
                                                                                            // and in the style of an Alert
    
    [popUp addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull subjectTitle){      // Adds a text field to the popup
        subjectTitle.placeholder = @"Subject Title"; }];                                    // with the placeholder "Subject Title"
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" // Creates an Alert action (button) in the style cancel
    style:UIAlertActionStyleCancel handler:nil];                     // which closes the parent popup when its pressed
    
    [popUp addAction:cancel];                                        // Adds the action cancel to the popup *popup
    
    UIAlertAction *create = [UIAlertAction actionWithTitle:@"Create Subject"                                // Creates an Alert action in the style destructive
                            style:UIAlertActionStyleDestructive handler:^(UIAlertAction *subjectCreated){   // similar to cancel, but its handler calls the
                                                                                                            // following block when pressed
        NSString *subjectName = [[popUp textFields][0] text];
        
        if ([self.data.subjects[@"keyArray"] containsObject:subjectName]){
            UIAlertController *invalidTitle = [UIAlertController alertControllerWithTitle:@"Warning" message:@"You cannot have two subjects with the same title\nPlease use a different subject title" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:nil];
            [invalidTitle addAction:ok];
            
            [self presentViewController:invalidTitle animated:YES completion:nil];
        } else {
            
            self.data.subjects = [self.data load];
            self.data.subjects[subjectName] = [self.data.subjectTemplate mutableCopy];
            
            [self.data.subjects[@"keyArray"] insertObject:subjectName atIndex:0];
            
            [self.data save:self.data.subjects];
            
            [self.tableView reloadData];
            [self viewDidLoad];
            
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            
            [self performSegueWithIdentifier:@"showDetail" sender:self];
        }
        
    }];
    
    [popUp addAction:create];
    
    [self presentViewController:popUp animated:YES completion:nil];

}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.data.subjects.count - 1);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubjectCell" forIndexPath:indexPath];
    
    //NSArray *getkeys = [self.data.subjects allKeys];
    //NSString *subjectID = [getkeys objectAtIndex:indexPath.row];
    
    
    
    cell.textLabel.text = [self.data.subjects[@"keyArray"] objectAtIndex:indexPath.row];
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSString *subjectKey = self.data.subjects[@"keyArray"][indexPath.row];
        NSString *warningMessage = [NSString stringWithFormat:@"Are you sure you want to delete %@",subjectKey];
        
        UIAlertController *deleteWarning = [UIAlertController alertControllerWithTitle:@"Warning" message:warningMessage preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *objectDeleted){
            [self.data.subjects removeObjectForKey:subjectKey];
            [self.data.subjects[@"keyArray"] removeObjectAtIndex:indexPath.row];
            
            [self.data save:self.data.subjects];
            [self.tableView reloadData];
            [self viewDidLoad];
            
            if (self.detailViewController.subjectID == subjectKey){
                self.detailViewController.subjectID = NULL;
                [self.detailViewController viewDidLoad];
            }
            
        }];
        [deleteWarning addAction:yes];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [deleteWarning addAction:cancel];
        
        [self presentViewController:deleteWarning animated:YES completion:nil];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        DetailViewController *detailViewController = (DetailViewController *)[[segue destinationViewController] topViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        //NSArray *getkeys = [self.data.subjects allKeys];
        //NSString *subjectID = [getkeys objectAtIndex:indexPath.row];
        
        detailViewController.subjectID = [self.data.subjects[@"keyArray"] objectAtIndex:indexPath.row];
        
        detailViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        detailViewController.navigationItem.leftItemsSupplementBackButton = YES;
        
    }
}


@end
