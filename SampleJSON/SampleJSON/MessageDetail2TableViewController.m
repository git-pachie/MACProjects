//
//  MessageDetail2TableViewController.m
//  PickupLines
//
//  Created by Archie Angeles on 2/9/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "MessageDetail2TableViewController.h"
#import "UseInformationUIView.h"
#import "CommonSendRequest.h"
#import "CommonFunction.h"

@interface MessageDetail2TableViewController ()

{
    CommonSendRequest *comreq;
}

@end

@implementation MessageDetail2TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    comreq = [[CommonSendRequest alloc]init];
    
    UseInformationUIView *customView = [UseInformationUIView customView];
    
    self.createdByPhoneNumber =  @"00000000"; //change
    self.HiritMessage = @"Alam mo para kang ihi 12345678 hindi mapakali";
    self.Answer = @"Hindi kasi kita matiis eh he he he 12345 ewan ko ba";
    
    [self roundImage:self.createdByPhoneNumber UserImage:customView.imgProfileImage];
    
    [self.cellUserProfile addSubview:customView];
    
    [self setStyleForPickupLines:self.lblhiritMessage :self.HiritMessage :self.Answer ];

    
    
    self.cellanswer1.accessoryType = UITableViewCellAccessoryNone;
    self.cellanswer2.accessoryType = UITableViewCellAccessoryNone;
    self.cellanswer3.accessoryType = UITableViewCellAccessoryNone;
    
    self.answer1.text = @"Hindi kasi kita matiis";
    self.answer2.text = @"Wala lang";
    self.answer3.text = @"Ang panghe mo kasi";
    
    
//    view.layer.cornerRadius = view.frame.size.height / 2;
//    view.layer.masksToBounds = YES;
//    
//    view.alpha  = 0.8;
//    view.layer.borderColor = [UIColor whiteColor].CGColor;
//    view.layer.borderWidth = 10;
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 6;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell == self.cellanswer1) {
        
        [self appcellButtonStyle:cell answer:self.answer1];
        
    }
    else if (cell == self.cellanswer2) {
        
        [self appcellButtonStyle:cell answer:self.answer2];
        
    }
    else if (cell == self.cellanswer3) {
        
        [self appcellButtonStyle:cell answer:self.answer3];
        
    }

    

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexpath %ld",(long)indexPath.row);
    
    UITableViewCell *theCellClicked = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (theCellClicked != self.cellanswer1 && theCellClicked != self.cellanswer2 && theCellClicked != self.cellanswer3) {
        return;
    }
    
    self.cellanswer1.accessoryType = UITableViewCellAccessoryNone;
    self.cellanswer2.accessoryType = UITableViewCellAccessoryNone;
    self.cellanswer3.accessoryType = UITableViewCellAccessoryNone;
    
    
    
    
    
    if (theCellClicked == self.cellanswer1) {
        //Do stuff
        self.cellanswer1.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if (theCellClicked == self.cellanswer2)
    {
        self.cellanswer2.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if (theCellClicked == self.cellanswer3)
    {
        self.cellanswer3.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}



-(void)roundImage:(NSString *)phoneNumber UserImage:(UIImageView*)imageview
{
    
    NSString *userImage = [CommonFunction ProfieImageURLByPhone:phoneNumber];
    
    //NSLog(@"userimage %@",userImage);
    
    [comreq downloadImageWithURL:[NSURL URLWithString:userImage] completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            
            imageview.image = image;
            
            [CommonFunction applyRoundBorderToImage:imageview];
            
        }
    }];
    
}

-(void)appcellButtonStyle :(UITableViewCell *)cell answer:(UILabel *)answer
{
    cell.layer.cornerRadius = cell.frame.size.height / 2;
    cell.layer.masksToBounds = YES;
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = 6;
    cell.backgroundColor = [UIColor purpleColor];
    cell.alpha = 0.4;
    answer.textColor = [UIColor whiteColor];

}

-(void)setStyleForPickupLines :(UILabel *)label :(NSString *)headerText :(NSString *)detailText
{
    [label setNumberOfLines:0];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    //[cell.labelMessage setBackgroundColor:[UIColor greenColor]];
    
    CGFloat width = 283;
    UIFont *font = [UIFont fontWithName:@"TrebuchetMS" size:18];
    
    NSMutableParagraphStyle *pStyle =  [[NSMutableParagraphStyle alloc]init];
    [pStyle setLineSpacing:4];
    
    
    NSMutableAttributedString
    *attributedText =  [[NSMutableAttributedString alloc] initWithString:detailText                                                              attributes:@
                        {
                        NSFontAttributeName: font
                        }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    [attributedText addAttribute:NSParagraphStyleAttributeName value:pStyle range:NSMakeRange(0, attributedText.length)];
    
    
    
    UIFont *myboldFont = [UIFont fontWithName:@"TrebuchetMS-Bold" size:21];
    
    NSMutableAttributedString
    *attributedText2 =  [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%1@\n\n", headerText]
                                                               attributes:@
                         {
                         NSFontAttributeName: myboldFont
                         }];
    //CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
    //options:NSStringDrawingUsesLineFragmentOrigin
    //context:nil];
    
    [attributedText2 appendAttributedString:attributedText];
    
    label.attributedText = attributedText2 ;
    
    
    [label setFrame:rect];
    
    [label sizeToFit];
    
}

@end
