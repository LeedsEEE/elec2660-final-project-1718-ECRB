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
    
    
    
    // Do any additional setup after loading the view.
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
    } else {
        NSMutableArray *tempDataArray = [[NSMutableArray alloc] init];
        
        [tempDataArray addObject: [[NSNumber alloc] initWithFloat:0.25]];
        [tempDataArray addObject: [[NSNumber alloc] initWithFloat:0.25]];
        [tempDataArray addObject: [[NSNumber alloc] initWithFloat:0.25]];
    }
    return tempDataArray;
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
