//
//  CustomTableViewCell.h
//  ToPeso
//
//  Created by pachie on 27/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblRemmitanceName;
@property (weak, nonatomic) IBOutlet UILabel *lblRemittanceAddress;
@property (weak, nonatomic) IBOutlet UIImageView *imgRemittanceImage;
@property (weak, nonatomic) IBOutlet UILabel *lblRate;
@property (weak, nonatomic) IBOutlet UILabel *lblAsOfDate;
@property (weak, nonatomic) IBOutlet UILabel *lblRemittancePhone;
@property (weak, nonatomic) IBOutlet UILabel *lblRemittanceEmail;

@end
