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
    
    self.BTCreateEntry.layer.cornerRadius = 10;
    
    if (self.subject) {
        self.subjectNavigation.title = self.subject.title;
        
        self.date = [[Date alloc] init]; //Initiate local DateFormatter
        self.LBStartDate.text = [self.date.dateFormatter stringFromDate:self.subject.startDate];
        self.LBFinishDate.text = [self.date.dateFormatter stringFromDate:self.subject.finishDate];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
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
        
    }
}

@end
