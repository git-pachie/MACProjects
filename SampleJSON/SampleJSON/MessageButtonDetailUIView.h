//
//  MessageButtonDetailUIView.h
//  PickupLines
//
//  Created by pachie on 2/9/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageButtonDetailUIView : UIView


@property (weak, nonatomic) IBOutlet UITableViewCell *cell11;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell22;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell33;


@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;



- (IBAction)btnaction1:(id)sender;
- (IBAction)btnaction2:(id)sender;
- (IBAction)btnaction3:(id)sender;



@property (nonatomic, assign) NSInteger selectedButton;
@property (nonatomic, strong) NSString *selectedAnswer;



+ (id)customView;
-(void)prepareButton :(NSString *)answer1 Answer2:(NSString *)answer2 Answer3:(NSString *)answer3;
@end
