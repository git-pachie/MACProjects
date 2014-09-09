//
//  PickupLineTableViewCell.h
//  PickupLines
//
//  Created by Archie Angeles on 1/9/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickupLineTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgUserImage;
@property (weak, nonatomic) IBOutlet UILabel *lblPickupLine;
@property (weak, nonatomic) IBOutlet UILabel *lblSubmitted;
@property (weak, nonatomic) IBOutlet UILabel *lblPoints;

@end
