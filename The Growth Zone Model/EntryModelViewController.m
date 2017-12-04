//
//  EntryModelViewController.m
//  The Growth Zone Model
//
//  Created by Edward Baker on 04/12/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import "EntryModelViewController.h"

@interface EntryModelViewController ()

@end

@implementation EntryModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [[DataModel alloc] init];
    
    int anxietyRadius = 0.80;
    int growthRadius = 0.60;
    int comfortRadius = 0.40;
    
    [self.view addSubview:[self circleWithColor:[UIColor redColor] radius:anxietyRadius * self.width/2 posx:self.width/2 posy:self.width/2]];
    [self.view addSubview:[self circleWithColor:[UIColor yellowColor] radius:growthRadius  * self.width/2 posx:self.width/2 posy:self.width/2]];
    [self.view addSubview:[self circleWithColor:[UIColor greenColor] radius:comfortRadius * self.width/2 posx:self.width/2 posy:self.width/2]];
    
    float pi = 3.14;
    
    self.anxietyArea = pi * anxietyRadius * anxietyRadius;
    self.growthArea = pi * growthRadius * growthRadius;
    self.comfortArea = pi * comfortRadius * comfortRadius;
    
#warning Make the above values go into the data, and then save the data (force a refresh on parent?)
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)circleWithColor:(UIColor *)color radius:(int)radius posx:(int)posx posy:(int)posy {
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(posx - radius, posy - radius, radius*2, radius*2)];
    circle.backgroundColor = color;
    circle.layer.cornerRadius = radius;
    circle.layer.masksToBounds = YES;
    return circle;
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
