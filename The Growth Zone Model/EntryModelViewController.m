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
    
    self.anxietyRadius = 0.80 * self.width/2;
    self.growthRadius = 0.60 * self.width/2;
    self.comfortRadius = 0.40 * self.width/2;
    
    
    
    [self.view addSubview:[self circleWithColor:[UIColor redColor] radius:self.anxietyRadius posx:self.width/2 posy:self.width/2]];
    [self.view addSubview:[self circleWithColor:[UIColor yellowColor] radius:self.growthRadius posx:self.width/2 posy:self.width/2]];
    [self.view addSubview:[self circleWithColor:[UIColor greenColor] radius:self.comfortRadius posx:self.width/2 posy:self.width/2]];
    
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
