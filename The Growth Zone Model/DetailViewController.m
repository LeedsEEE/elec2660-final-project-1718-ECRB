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


@end
