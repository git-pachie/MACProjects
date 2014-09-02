//
//  MessageButtonDetailUIView.m
//  PickupLines
//
//  Created by pachie on 2/9/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "MessageButtonDetailUIView.h"

@implementation MessageButtonDetailUIView
{
    NSMutableArray *buttonArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+ (id)customView
{
    MessageButtonDetailUIView *customView = [[[NSBundle mainBundle] loadNibNamed:@"MessageDetailButton" owner:nil options:nil] lastObject];
    
    // make sure customView is not nil or the wrong class!
    if ([customView isKindOfClass:[MessageButtonDetailUIView class]])
        
        
    
    
        return customView;
    else
        return nil;
}

-(void)prepareButton :(NSString *)answer1 Answer2:(NSString *)answer2 Answer3:(NSString *)answer3
{
    buttonArray = [[NSMutableArray alloc]init];
    
    self.cell11.tag = 1;
    self.btn1.titleLabel.text = answer1;
    self.btn1.tag = 1;
    
    self.cell22.tag = 2;
    self.btn2.titleLabel.text = answer2;
    self.btn2.tag = 2;
    
    self.cell33.tag = 3;
    self.btn3.titleLabel.text = answer3;
    self.btn3.tag = 3;
    
    [buttonArray addObject:self.cell11];
    [buttonArray addObject:self.cell22];
    [buttonArray addObject:self.cell33];
}



-(void)applyToggleButton : (NSArray *)buttonArrary : (NSInteger )currentButtonTag
{
    //NSMutableArray *buttonArray = [[NSMutableArray alloc]init];
    
    [self removeCheck:buttonArray];
    
    self.btn1.titleLabel.text = @"archie";
    self.btn2.titleLabel.text = @"archie2";
    self.btn3.titleLabel.text = @"archie3";
    
    for (UITableViewCell *cell in buttonArrary) {
        
            
        if (cell.tag == currentButtonTag) {
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.selectedButton = cell.tag;
            self.selectedAnswer = @"here is the answer";
            
        }
        
    }
  
    
}

-(void)removeCheck : (NSArray *)buttonArrary
{
    for (UITableViewCell *cell in buttonArrary) {
        
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
}




- (IBAction)btnaction1:(id)sender {
    [self applyToggleButton:buttonArray :1];
}

- (IBAction)btnaction2:(id)sender {
    [self applyToggleButton:buttonArray :2];
}

- (IBAction)btnaction3:(id)sender {
    [self applyToggleButton:buttonArray :3];
}
@end
