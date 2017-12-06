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
    
    [self drawGraph];
    // Do any additional setup after loading the view.
}



-(void)drawGraph{
    self.data = [[DataModel alloc] init];
    
    self.entrys = self.data.subjects[self.subjectID][@"entrys"];
    
    self.sortedKeys = [[self.entrys allKeys] sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        if ([a length] != [b length]) {
            return [[NSNumber numberWithInteger:[a length]] compare:[NSNumber numberWithInteger:[b length]]];
        } else {
            return [a compare:b];
        }}];
    
#warning above is incorect
    
    
    NSLog(@"%@",self.sortedKeys);
    
    [self drawGraphFromArray:[self dataArray]];
}

- (void)drawGraphFromArray:(NSArray *)array {
    
    float pixelWidth = self.view.bounds.size.width * (0.6 + 0.4 * [self.splitViewController preferredDisplayMode]) - 54;

    float pixelHeight = (self.view.bounds.size.height - self.navigationController.navigationBar.frame.size.height - UIApplication.sharedApplication.statusBarFrame.size.height - 75) / 2 - 20;
    float arraySize = (int)array.count - 1;
    float xmultiplier = (arraySize / pixelWidth);
    float ymultiplier = (pixelHeight/100);

    [self.view.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    if (arraySize > 0) {
        for (int i = 0; i < (pixelWidth); i++){
            int prev = floor(xmultiplier*i);
            int next = ceil(xmultiplier*i);
            int prevPixel = prev / xmultiplier;
            int nextPixel = next / xmultiplier;
            
            float comfortHeight = 0.0;
            float growthHeight = 0.0;
            float anxietyHeight = 0.0;
            
            if (prevPixel == nextPixel) {
                comfortHeight = [array[prev][0] floatValue] * ymultiplier;
                growthHeight = [array[prev][1] floatValue] * ymultiplier;
                anxietyHeight = [array[prev][2] floatValue] * ymultiplier;
                
            } else {
                comfortHeight = floor((([array[next][0] floatValue] - [array[prev][0] floatValue]) * (i - prevPixel) / (nextPixel - prevPixel) + [array[prev][0] floatValue]) * ymultiplier);
                growthHeight = floor((([array[next][1] floatValue] - [array[prev][1] floatValue]) * (i - prevPixel) / (nextPixel - prevPixel) + [array[prev][1] floatValue]) * ymultiplier);
                anxietyHeight = floor((([array[next][2] floatValue] - [array[prev][2] floatValue]) * (i - prevPixel) / (nextPixel - prevPixel) + [array[prev][2] floatValue]) * ymultiplier);
            }
            [self.view addSubview:[self rectWithColour:[UIColor redColor] posx:i+2 posy:2+pixelHeight-anxietyHeight  width:1 height:anxietyHeight]];
            [self.view addSubview:[self rectWithColour:[UIColor yellowColor] posx:i+2 posy:2+pixelHeight-growthHeight width:1 height:growthHeight]];
            [self.view addSubview:[self rectWithColour:[UIColor greenColor] posx:i+2 posy:2+pixelHeight-comfortHeight width:1 height:comfortHeight]];
        }
    } else {
        float comfortHeight = [array[0][0] floatValue] * ymultiplier;
        float growthHeight = [array[0][1] floatValue] * ymultiplier;
        float anxietyHeight = [array[0][2] floatValue] * ymultiplier;
        
        [self.view addSubview:[self rectWithColour:[UIColor redColor] posx:2 posy:2+pixelHeight-anxietyHeight  width:pixelWidth height:anxietyHeight]];
        [self.view addSubview:[self rectWithColour:[UIColor yellowColor] posx:2 posy:2+pixelHeight-growthHeight width:pixelWidth height:growthHeight]];
        [self.view addSubview:[self rectWithColour:[UIColor greenColor] posx:2 posy:2+pixelHeight-comfortHeight width:pixelWidth height:comfortHeight]];
        
    }
}
                                                                                                    
-(NSArray *)dataArray
{
    NSMutableArray *tempDataArray = [[NSMutableArray alloc] init];
    
    if (self.sortedKeys.count > 0)
    {
        for (NSString *currentKey in self.sortedKeys)
        {
            NSMutableArray *singleEntryArray = [[NSMutableArray alloc] init];
            
            [singleEntryArray addObject:self.entrys[currentKey][@"comfortArea"]];
            [singleEntryArray addObject:[[NSNumber alloc] initWithInt:([self.entrys[currentKey][@"growthArea"] intValue] + [self.entrys[currentKey][@"comfortArea"] intValue])]];
            [singleEntryArray addObject:[[NSNumber alloc] initWithInt:([self.entrys[currentKey][@"anxietyArea"] intValue] + [self.entrys[currentKey][@"growthArea"] intValue] + [self.entrys[currentKey][@"comfortArea"] intValue])]];
            
            [tempDataArray addObject:singleEntryArray];
        }
    } else {
        NSMutableArray *singleEntryArray = [[NSMutableArray alloc] init];
        
        [singleEntryArray addObject: [[NSNumber alloc] initWithInt:25]];
        [singleEntryArray addObject: [[NSNumber alloc] initWithInt:50]];
        [singleEntryArray addObject: [[NSNumber alloc] initWithInt:75]];
        
        [tempDataArray addObject:singleEntryArray];
    }
    return tempDataArray;
}


- (UIView *)rectWithColour:(UIColor *)colour posx:(int)posx posy:(int)posy width:(int)width height:(int)height{
    UIView *rect = [[UIView alloc] initWithFrame:CGRectMake(posx, posy, width, height)];
    rect.backgroundColor = colour;
    rect.layer.masksToBounds = YES;
    return rect;
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
