//
//  ProgressGraphViewController.m
//  The Growth Zone Model
//
//  Created by Edward Baker on 01/12/2017.
//  Copyright © 2017 Edward Baker [el16ecrb]. All rights reserved.
//

#import "ProgressGraphViewController.h"

@interface ProgressGraphViewController ()

@end

@implementation ProgressGraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.graphArray = [self dataArray];
    
    //[self.view addSubview:[self groundedTrapezium:[UIColor grayColor] posx:30 width:40 height1:10 height2:20]];

    NSLog(@"%@",self.subjectID);
    // Do any additional setup after loading the view.
}

- (void) drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    int width = 40;
    int height = 40;
    
    
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, width / 4, height / 4);
    CGContextAddLineToPoint(context, width * 3 / 4, height / 2);
    CGContextAddLineToPoint(context, width / 4, height * 3 / 4);
    CGContextClosePath(context);
    
    CGContextSetRGBFillColor(context, 1, 1, 0, 1);
    CGContextFillPath(context);
    
    /*
    UIView *trapezium = [[UIView alloc] init];
    [trapezium.layer renderInContext:context];
    trapezium.backgroundColor = [UIColor grayColor];
    trapezium.layer.masksToBounds = YES;
    */
    
}

-(NSArray *)dataArray
{
    NSMutableDictionary *entryDict = self.data.subjects[self.subjectID][@"entrys"];
    NSArray *entryKeys = [entryDict allKeys];
    NSMutableArray *tempDataArray = [[NSMutableArray alloc] init];
    
    if (entryKeys.count > 0)
    {
        for (NSString *currentKey in entryKeys)
        {
            NSMutableArray *singleEntryArray = [[NSMutableArray alloc] init];
            
            [singleEntryArray addObject:entryDict[currentKey][@"comfortArea"]];
            [singleEntryArray addObject:entryDict[currentKey][@"growthArea"]];
            [singleEntryArray addObject:entryDict[currentKey][@"anxietyArea"]];
            
            [tempDataArray addObject:singleEntryArray];
        }
        return tempDataArray;
    } else {
        return nil;
    }
}

- (UIView *)groundedTrapezium:(UIColor *)colour posx:(int)posx width:(int)width height1:(int)height1 height2:(int)height{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    
    CGContextSetFillColorWithColor(context, colour.CGColor);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, width / 4, height1 / 4);
    CGContextAddLineToPoint(context, width * 3 / 4, height1 / 2);
    CGContextAddLineToPoint(context, width / 4, height1 * 3 / 4);
    CGContextAddLineToPoint(context, width / 4, height1 / 4);
    CGContextFillPath(context);
    
    /*
    UIView *trapezium = [[UIView alloc] init];
    [trapezium.layer renderInContext:context];
    trapezium.backgroundColor = colour;
    trapezium.layer.masksToBounds = YES;
    
    return trapezium;
    */
    return NULL;
}


- (UIView *)circleWithColor:(UIColor *)color radius:(int)radius posx:(int)posx posy:(int)posy {
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(posx, posy, radius*2, radius*2)];
    circle.backgroundColor = color;
    circle.layer.cornerRadius = radius;
    circle.layer.masksToBounds = YES;
    return circle;
}

- (UIView *)rectWithColor:(UIColor *)color posx:(int)posx posy:(int)posy width:(int)width height:(int)height{
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(posx, posy, width, height)];
    circle.backgroundColor = color;
    circle.layer.masksToBounds = YES;
    return circle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
