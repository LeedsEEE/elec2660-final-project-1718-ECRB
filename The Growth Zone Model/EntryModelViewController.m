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
    self.entry = self.data.subjects[self.subjectID][@"entrys"][self.entryID];
    
    [self.view addSubview:[self circleWithColor:[UIColor whiteColor] radius:0.5 * self.width - 4 posx:self.width/2 posy:self.width/2 border:2.0]];
    
    float anxietyRadius = 0.40;
    float growthRadius = 0.30;
    float comfortRadius = 0.20;
    float radiusMultiplier = self.width - 12;
    
    [self.view addSubview:[self circleWithColor:[UIColor redColor] radius:anxietyRadius * radiusMultiplier posx:self.width/2 posy:self.width/2 border:0.0]];
    [self.view addSubview:[self circleWithColor:[UIColor yellowColor] radius:growthRadius  * radiusMultiplier posx:self.width/2 posy:self.width/2 border:0.0]];
    [self.view addSubview:[self circleWithColor:[UIColor greenColor] radius:comfortRadius * radiusMultiplier posx:self.width/2 posy:self.width/2 border:0.0]];
    
    int comfortArea = round(pow(comfortRadius*2,2) * 100);
    int growthArea = round(pow(growthRadius*2,2) * 100) - comfortArea;
    int anxietyArea = round(pow(anxietyRadius*2,2) * 100) - growthArea - comfortArea;
    
    self.entry[@"anxietyArea"] = [[NSNumber alloc] initWithInt:anxietyArea];
    self.entry[@"growthArea"] = [[NSNumber alloc] initWithInt:growthArea];
    self.entry[@"comfortArea"] = [[NSNumber alloc] initWithInt:comfortArea];
    
    [self.data save:self.data.subjects];
        
    // Do any additional setup after loading the view.
}

- (IBAction)pan:(id)sender {
    UIPanGestureRecognizer *moveCircles = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveCircle:)];
    
    moveCircles.minimumNumberOfTouches = 1;
    moveCircles.maximumNumberOfTouches = 1;
    
    [self.view addGestureRecognizer:moveCircles];
}

- (void)moveCircle:(UIPanGestureRecognizer *)panning
{
    CGPoint current = [panning locationInView:self.view];
    CGPoint translation = [panning translationInView:self.view];
    
    CGPoint startCentered = CGPointMake(current.x-translation.x-self.width/2, current.y-translation.y-self.width/2);
    CGPoint currentCentered = CGPointMake(current.x-self.width/2, current.y-self.width/2);
    
    float stardRad = powf(powf(startCentered.x, 2)+powf(startCentered.y, 2), 0.5);
  
    NSLog(@"%f",stardRad);
    //NSLog(@"X:%f Y:%f",startCentered.x,startCentered.y);
    //NSLog(@"X:%f Y:%f",current.x,current.y);
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)circleWithColor:(UIColor *)color radius:(int)radius posx:(int)posx posy:(int)posy border:(float)border{
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(posx - radius, posy - radius, radius*2, radius*2)];
    circle.backgroundColor = color;
    circle.layer.cornerRadius = radius;
    circle.layer.masksToBounds = YES;
    circle.layer.borderWidth = border;
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
