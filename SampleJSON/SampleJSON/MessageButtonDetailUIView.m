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
    self.lbl1.text = answer1;
    
    self.cell22.tag = 2;
    self.lbl2.text = answer2;
    
    self.cell33.tag = 3;
    self.lbl3.text = answer3;
    
    [buttonArray addObject:self.cell11];
    [buttonArray addObject:self.cell22];
    [buttonArray addObject:self.cell33];
}



-(void)applyToggleButton : (NSArray *)buttonArrary : (NSInteger )currentButtonTag
{
    //NSMutableArray *buttonArray = [[NSMutableArray alloc]init];
    
    for (UITableViewCell *cell in buttonArrary) {
        
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        
        if (cell.tag == currentButtonTag) {
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.selectedButton = cell.tag;
            self.selectedAnswer = @"here is the answer";
            
        }
        
    }
  
    
}


- (IBAction)btnTest:(id)sender {
    [self applyToggleButton:buttonArray :1];
}
@end
