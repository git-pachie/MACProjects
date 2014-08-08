//
//  MyTableViewCell.h
//  CustomCell2
//
//  Created by pachie on 8/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelSentReceivedDate;
@property (weak, nonatomic) IBOutlet UILabel *lablePickupLineHeader;
@property (weak, nonatomic) IBOutlet UILabel *labelPickupLineAnswer;
@property (weak, nonatomic) IBOutlet UILabel *labelCreatedby;
@property (weak, nonatomic) IBOutlet UILabel *labelSendReceived;

@end
