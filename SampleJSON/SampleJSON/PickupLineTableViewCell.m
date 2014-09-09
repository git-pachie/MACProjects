//
//  PickupLineTableViewCell.m
//  PickupLines
//
//  Created by Archie Angeles on 1/9/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "PickupLineTableViewCell.h"

@implementation PickupLineTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
