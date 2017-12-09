//
//  EntryTableViewController.m
//  The Growth Zone Model
//
//  Created by Edward Baker on 24/11/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import "EntryTableViewController.h"

@interface EntryTableViewController ()

@end

@implementation EntryTableViewController

#pragma mark - Initialisation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [[DataModel alloc] init]; //Initialise DataModel
    self.date = [[Date alloc] init];      //Initialise local DateFormatter
    
    if (self.subjectID) {
        self.subject = self.data.subjects[self.subjectID]; //If there is a subject ID, set self.subject
    }
}

#pragma mark - Reload Table

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.data.subjects = [self.data load];
    
    self.sortedKeys = [[self.data.subjects[self.subjectID][@"entrys"] allKeys] sortedArrayUsingComparator:^NSComparisonResult(id a, id b) { // Similar sort has been used before
        if (([a length] != [b length]) && ([a substringToIndex:9] == [b substringToIndex:9])) {                                             // Sorts keys alphabetically and by
            return [[NSNumber numberWithInteger:[b length]] compare:[NSNumber numberWithInteger:[a length]]];                               // iteration
        } else {
            return [b compare:a];
    }}];
    
    [self.tableView reloadData]; // Reload the tableview
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { //Returns the sections in the entry table
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { // Checks if there is a subject selected, if there is return the amount of entries
    if (self.subject) {
        return [self.data.subjects[self.subjectID][@"entrys"] allKeys].count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EntryCell" forIndexPath:indexPath]; // Returns the entryKey at the index of the current cell
    
    NSString *entryID = [self.sortedKeys objectAtIndex:indexPath.row];
    
    cell.textLabel.text = entryID;
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"showEntryDetail"]) {
        
        EntryViewController *destinationViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSString *entryID = [self.sortedKeys objectAtIndex:indexPath.row];
        
        destinationViewController.entryID = entryID;
        destinationViewController.subjectID = self.subjectID;
        
        self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden; //When you select an entry the master view is hidden
        
    }
}

#pragma mark - Future Use

/*

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 

 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }



 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }



 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
}

*/

@end
