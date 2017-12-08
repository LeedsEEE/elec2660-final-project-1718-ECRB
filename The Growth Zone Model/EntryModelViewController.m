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

#pragma mark - Initialisation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.entryViewController viewDidLoad];
    
    self.data = [[DataModel alloc] init];
    
    self.entry = self.entryViewController.entry;
    
    self.radiusMultiplier = self.width - 12;
    
    self.tolerance = 0.005;
    
    if (self.entry[@"anxietyRadius"] == NULL){
        self.entry[@"anxietyRadius"] = [[NSNumber alloc] initWithFloat:0.4];
        self.entry[@"growthRadius"] = [[NSNumber alloc] initWithFloat:0.3];
        self.entry[@"comfortRadius"] = [[NSNumber alloc] initWithFloat:0.2];
        
    }
    
    [self updateCircles];
    // Do any additional setup after loading the view.
}

#pragma mark - Gesture Recognition

- (IBAction)pan:(id)sender {
    UIPanGestureRecognizer *moveCircles = [[UIPanGestureRecognizer alloc] // Creates the gesture recogniser that calls the method moveCircle
    initWithTarget:self action:@selector(moveCircle:)];                   // when a gesture is recognised
    
    moveCircles.minimumNumberOfTouches = 1; // Sets the minimum amount of gestures to recognise a pan to 1
    moveCircles.maximumNumberOfTouches = 1; // Sets the max to 1, hence it will only register single touch
    
    [self.view addGestureRecognizer:moveCircles]; // Adds the gesture recogniser, moveCircles, to the self.view
}

- (void)moveCircle:(UIPanGestureRecognizer *)panning
{
    if(panning.state == UIGestureRecognizerStateEnded){
        self.selected = NULL;
    } else {
        CGPoint current = [panning locationInView:self.view];
        CGPoint translation = [panning translationInView:self.view];
    
        CGPoint startCentered = CGPointMake(current.x-translation.x-self.width/2, current.y-translation.y-self.width/2);
        CGPoint currentCentered = CGPointMake(current.x-self.width/2, current.y-self.width/2);
    
        float stardRad = powf(powf(startCentered.x, 2)+powf(startCentered.y, 2), 0.5)/self.radiusMultiplier;
        float currentRad = powf(powf(currentCentered.x, 2)+powf(currentCentered.y, 2), 0.5)/self.radiusMultiplier;

        float anxietyDiff = fabs([self.entry[@"anxietyRadius"] floatValue] - stardRad);
        float growthDiff = fabs([self.entry[@"growthRadius"] floatValue] - stardRad);
        float comfortDiff = fabs([self.entry[@"comfortRadius"] floatValue] - stardRad);
        
        if (self.selected) {
            [self radiusCheckForCircle:self.selected withRadius:currentRad];
        } else {
            if ((anxietyDiff < growthDiff) && (anxietyDiff < comfortDiff)){
                self.selected = @"anxiety";
            } else if ((growthDiff < anxietyDiff) && (growthDiff < comfortDiff)){
                self.selected = @"growth";
            } else {
                self.selected = @"comfort";
            }
        }
        [self updateCircles];
    }
}

#pragma mark - Draw Model

- (void)updateCircles {
    
    [self.view.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [self.view addSubview:[self circleWithColor:[UIColor whiteColor] radius:0.5 * self.width - 4 posx:self.width/2 posy:self.width/2 border:2.0]];
    
    [self.view addSubview:[self circleWithColor:[UIColor redColor] radius:[self.entry[@"anxietyRadius"] floatValue] * self.radiusMultiplier posx:self.width/2 posy:self.width/2 border:0.0]];
    [self.view addSubview:[self circleWithColor:[UIColor yellowColor] radius:[self.entry[@"growthRadius"] floatValue] * self.radiusMultiplier posx:self.width/2 posy:self.width/2 border:0.0]];
    [self.view addSubview:[self circleWithColor:[UIColor greenColor] radius:[self.entry[@"comfortRadius"] floatValue] * self.radiusMultiplier posx:self.width/2 posy:self.width/2 border:0.0]];
    
    int comfortArea = round(pow(([self.entry[@"comfortRadius"] floatValue] + self.tolerance * 2) * 2,2) * 100);
    int growthArea = round(pow(([self.entry[@"growthRadius"] floatValue] + self.tolerance) * 2,2) * 100) - comfortArea;
    int anxietyArea = round(pow([self.entry[@"anxietyRadius"] floatValue] * 2,2) * 100) - growthArea - comfortArea;
    
    self.entry[@"anxietyArea"] = [[NSNumber alloc] initWithInt:anxietyArea];
    self.entry[@"growthArea"] = [[NSNumber alloc] initWithInt:growthArea];
    self.entry[@"comfortArea"] = [[NSNumber alloc] initWithInt:comfortArea];
    
    NSLog(@"%@model",self.entry);
    
    self.entryViewController.entry = self.entry;
    [self.entryViewController updateLabels_comfort:comfortArea growth:growthArea anxiety:anxietyArea];
}


- (float)radiusCheckForCircle:(NSString *)circle withRadius:(float)radius {
    
    float tempRadius;
    
    if ([circle  isEqual: @"anxiety"]){
        if (radius > 0.5){
            tempRadius = 0.5;
        } else if (radius > ([self.entry[@"growthRadius"] floatValue] + self.tolerance)) {
            tempRadius = radius;
        } else {
            tempRadius = [self radiusCheckForCircle: @"growth" withRadius:(radius-self.tolerance)] + self.tolerance;
        }
        self.entry[@"anxietyRadius"] = [[NSNumber alloc] initWithFloat:tempRadius];
        return tempRadius;
        
    } else if ([circle  isEqual: @"growth"]){
        if (radius > [self.entry[@"anxietyRadius"] floatValue] - self.tolerance){
            tempRadius = [self radiusCheckForCircle:@"anxiety" withRadius:radius + self.tolerance]  - self.tolerance;
        } else if (radius > ([self.entry[@"comfortRadius"] floatValue] + self.tolerance)) {
            tempRadius = radius;
        } else {
            tempRadius = [self radiusCheckForCircle: @"comfort" withRadius:(radius-self.tolerance)]  + self.tolerance;
        }
        self.entry[@"growthRadius"] = [[NSNumber alloc] initWithFloat:tempRadius];
        return tempRadius;
        
    } else if ([circle  isEqual: @"comfort"]){
        if (radius > [self.entry[@"growthRadius"] floatValue] - self.tolerance){
            tempRadius = [self radiusCheckForCircle:@"growth" withRadius:radius + self.tolerance]  - self.tolerance;
        } else if (radius > self.tolerance) {
            tempRadius = radius;
        } else {
            tempRadius = self.tolerance;
        }
        self.entry[@"comfortRadius"] = [[NSNumber alloc] initWithFloat:tempRadius];
        return tempRadius;
    } else {
        return 0.0;
    }
}

- (UIView *)circleWithColor:(UIColor *)color radius:(int)radius posx:(int)posx posy:(int)posy border:(float)border{ // Similar to function in progress graph
                                            // - (UIView *)rectWithColour:(UIColor *)colour posx:(int)posx posy:(int)posy width:(int)width height:(int)height
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(posx - radius, posy - radius, radius * 2, radius * 2)]; // Lets the user input the center of the circle and radius
    circle.backgroundColor = color;      // Sets the colour                                                           // rather than the topleft corner and width
    circle.layer.cornerRadius = radius;  // Sets the corner radius
    circle.layer.masksToBounds = YES;    // Limits the view drawing to its bounds
    circle.layer.borderWidth = border;   // Sets the border of the circle
    return circle;
}

#pragma mark - Future Use

/*
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/

@end
