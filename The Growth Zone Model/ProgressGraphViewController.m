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

#pragma mark - Initialisation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [[DataModel alloc] init]; // Initalise the datamodel
    
    self.border = 2;
    
}

#pragma mark - When to reload Graph

- (void)viewDidAppear:(BOOL)animated { //
    [self drawGraph];                  // Catches any time the graph is on screen
}                                      // and makes sure to reload it for any updates
                                       //
- (void)viewDidLayoutSubviews {        //
    [self drawGraph];                  //
    NSLog(@"layout");                  //
}

#pragma mark - Draw Graph

-(void)drawGraph{
    self.data.subjects = [self.data load]; // Reload the subject dictionary
    
    self.entrys = self.data.subjects[self.subjectID][@"entrys"]; // Sets self.entry to the relevant data to simplify code

    self.sortedKeys = [[self.entrys allKeys] sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {    // Sorts the entrys by date and the iteration
        if (([a length] != [b length]) && ([a substringToIndex:9] == [b substringToIndex:9])) {
            return [[NSNumber numberWithInteger:[a length]] compare:[NSNumber numberWithInteger:[b length]]];
        } else {
            return [a compare:b];
        }}];
    
    [self drawGraphFromArray:[self dataArray]]; // Calls drawgraph method with the array from dataArray method
}

- (void)drawGraphFromArray:(NSArray *)array {
    
    float pixelWidth = self.view.bounds.size.width - self.border * 2;   // Sets the pixelWidth to the view width minus a border offset
    float pixelHeight = self.view.bounds.size.height - self.border * 2; // Sets the pixelHeight
    
    float arrayGaps = (int)array.count - 1;       // Finds the amount of gaps between objects in the array
    float xmultiplier = (arrayGaps / pixelWidth); // Calculates one over the amount of pixels inbetween each entry point
    float ymultiplier = (pixelHeight/100);        // Calculates the PixelHeight over 100 to multiply the area percentage by

    [self.view.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)]; // Clears all the subviews - previous graphs
    
    if (arrayGaps > 0) {                            // Checks if there is more than one entry to graph
        for (int i = 0; i < (pixelWidth); i++){     // Iterates through each pixel
            
            int prev = floor(xmultiplier*i);        // Calculates the index of the entry before the current pixel
            int next = ceil(xmultiplier*i);         // Calculates the index of the entry after the current pixel
            float prevPixel = prev / xmultiplier;     // Calculates the theoretical horizontal pixel position of the previous entry
            float nextPixel = next / xmultiplier;     // Calculates the theoretical horizontal pixel position of the next entry
            
            float comfortHeight = 0.0; // Create the height variables
            float growthHeight = 0.0;  //
            float anxietyHeight = 0.0; //
            
            if (prevPixel == nextPixel) { // Checks if the current pixel is directly on one entry
                comfortHeight = [array[prev][0] floatValue] * ymultiplier;  // Sets the heights to the percentage
                growthHeight = [array[prev][1] floatValue] * ymultiplier;   // multiplied by the ymultiplier
                anxietyHeight = [array[prev][2] floatValue] * ymultiplier;  //
                
            } else {
                comfortHeight = (([array[next][0] floatValue] - [array[prev][0] floatValue]) * (i - prevPixel) // Calculates the change in height between the
                                 / (nextPixel - prevPixel) + [array[prev][0] floatValue]) * ymultiplier;       // previous and last entry per pixel
                growthHeight = (([array[next][1] floatValue] - [array[prev][1] floatValue]) * (i - prevPixel)  // mutliplies this by the amount of pixels
                                / (nextPixel - prevPixel) + [array[prev][1] floatValue]) * ymultiplier;        // the current pixel is after the previous entry
                anxietyHeight = (([array[next][2] floatValue] - [array[prev][2] floatValue]) * (i - prevPixel) // then adds this to the height of the previous entry
                                 / (nextPixel - prevPixel) + [array[prev][2] floatValue]) * ymultiplier;       // then mutliplies this by the y mutliplier
            }
            
            [self.view addSubview:[self rectWithColour:[UIColor redColor] posx:i + self.border
                                                  posy: self.border * 2 + pixelHeight - anxietyHeight  width:1 height:anxietyHeight]];  // Creates three stacked
            [self.view addSubview:[self rectWithColour:[UIColor yellowColor] posx:i + self.border                                       // lines for the current
                                                  posy: self.border * 2 + pixelHeight - growthHeight width:1 height:growthHeight]];     // x pixel of the graph
            [self.view addSubview:[self rectWithColour:[UIColor greenColor] posx:i + self.border                                        //
                                                  posy: self.border * 2 + pixelHeight - comfortHeight width:1 height:comfortHeight]];   //
            
        }
    } else { // There are less than two entrys, so create three simple rectangles rather than iterate through pixels
        
        float comfortHeight = [array[0][0] floatValue] * ymultiplier; // Calculates the heights of the bars
        float growthHeight = [array[0][1] floatValue] * ymultiplier;  //
        float anxietyHeight = [array[0][2] floatValue] * ymultiplier; //
        
        // Add the rectangles to the view
        [self.view addSubview:[self rectWithColour:[UIColor redColor] posx:self.border posy:self.border * 2 + pixelHeight - anxietyHeight  width:pixelWidth height:anxietyHeight]];
        [self.view addSubview:[self rectWithColour:[UIColor yellowColor] posx:self.border posy:self.border * 2 + pixelHeight - growthHeight width:pixelWidth height:growthHeight]];
        [self.view addSubview:[self rectWithColour:[UIColor greenColor] posx:self.border posy:self.border * 2 + pixelHeight - comfortHeight width:pixelWidth height:comfortHeight]];
        
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


- (UIView *)rectWithColour:(UIColor *)colour posx:(int)posx posy:(int)posy width:(int)width height:(int)height{ // Idea was gathered from a few StackOverflow threads, mainly;
    UIView *rect = [[UIView alloc] initWithFrame:CGRectMake(posx, posy, width, height)];            // https://stackoverflow.com/questions/14785188/drawing-rectangles-in-ios
    rect.backgroundColor = colour;
    rect.layer.masksToBounds = YES;                 // Creates a view with the dimensions and position of the given parameters, sets the colour and tells coregraphics to limit
    return rect;                                    // the view to its bounds, then returns the view
}

#pragma mark - Future Use

/*

 - (void)didReceiveMemoryWarning {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
 }

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
