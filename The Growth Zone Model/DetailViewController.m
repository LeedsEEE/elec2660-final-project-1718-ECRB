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

- (void)configureView {

    self.data = [[DataModel alloc] init];
    self.date = [[Date alloc] init]; //Initiate local DateFormatter
    
    self.BTCreateEntry.layer.cornerRadius = 10.0f;
    self.TBPastEntries.layer.borderColor = [[UIColor grayColor]CGColor];
    self.TBPastEntries.layer.borderWidth = 2.0f;
    self.progressGraph.layer.borderWidth = 2.0f;

    if (self.subjectID) {
        
        self.view.userInteractionEnabled = YES;
        
        self.subject = self.data.subjects[self.subjectID];
        
        self.title = self.subjectID;
        
        NSArray *sortedKeys = [[self.data.subjects[self.subjectID][@"entrys"] allKeys] sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            if (([a length] != [b length]) && ([a substringToIndex:9] == [b substringToIndex:9])) {
                return [[NSNumber numberWithInteger:[a length]] compare:[NSNumber numberWithInteger:[b length]]];
            } else {
                return [a compare:b];
        }}];
        
        if(sortedKeys.count){
            self.LBDates.text = [NSString stringWithFormat:@"%@ - %@", [[sortedKeys lastObject]substringToIndex:10], [sortedKeys[0] substringToIndex:10]];
        } else {
            self.LBDates.text = @"No Entries";
        }
        //Input the first and last date from the sorted keys, and remove any increment on the dates
        
    } else {
        self.view.userInteractionEnabled = NO;
        self.title = @"";
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleProminent];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
        blurView.frame = self.view.bounds;
        blurView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        self.overlayView.hidden = NO;

        [self.view insertSubview:blurView atIndex:2];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.data.subjects = [self.data load];

    [super viewWillAppear:animated];
    [self viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"showNewEntry"]) {
        
        self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden; //When you select an entry the master view is hidden
        
        self.entryTableViewController = [segue destinationViewController];
        
        self.entryTableViewController.subjectID = self.subjectID;
        
    } else if ([[segue identifier] isEqualToString:@"embed"]) {
        
        self.entryTableViewController = [segue destinationViewController];
        
        self.entryTableViewController.subjectID = self.subjectID;
        
    }
}

@end
