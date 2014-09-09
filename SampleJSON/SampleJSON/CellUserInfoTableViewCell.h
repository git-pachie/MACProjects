//
//  CellUserInfoTableViewCell.h
//  PickupLines
//
//  Created by Archie Angeles on 4/9/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellUserInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgUserImage;
@property (weak, nonatomic) IBOutlet UILabel *lblAlias;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneName;
@property (weak, nonatomic) IBOutlet UILabel *lblJoinDate;
@property (weak, nonatomic) IBOutlet UILabel *lblNumber;


@end
