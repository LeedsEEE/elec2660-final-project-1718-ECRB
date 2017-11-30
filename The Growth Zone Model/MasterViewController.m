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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [[DataModel alloc] init]; // Initiate DataModel
    
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    }



- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)insertNewObject:(id)sender {
    
#warning setup New subject
    
    
    UIAlertController *popUp = [UIAlertController alertControllerWithTitle:@"New Subject" message:@"Please enter your subject title" preferredStyle:UIAlertControllerStyleAlert];
    
    [popUp addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull subjectTitle){
        subjectTitle.placeholder = @"Subject Title";
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    [popUp addAction:cancel];
    
    
    UIAlertAction *create = [UIAlertAction actionWithTitle:@"Create Subject" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *subjectCreated){
        
        NSString *subjectName = [[popUp textFields][0] text];
        
        if ([self.data.subjects[@"keyArray"] containsObject:subjectName]){
            UIAlertController *invalidTitle = [UIAlertController alertControllerWithTitle:@"Warning" message:@"You cannot have two subjects with the same title\nPlease use a different subject title" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:nil];
            [invalidTitle addAction:ok];
            
            [self presentViewController:invalidTitle animated:YES completion:nil];
        } else {
            self.data.subjects[subjectName] = [self.data.subjectTemplate mutableCopy];
            [self.data.subjects[@"keyArray"] insertObject:subjectName atIndex:0];
            [self.data save:self.data.subjects];
            [self.tableView reloadData];
            [self viewDidLoad];
        }
        
    }];
    [popUp addAction:create];
    
    [self presentViewController:popUp animated:YES completion:nil];

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
#warning add delete support
        //[self.data.subjects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    
        
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


@end
