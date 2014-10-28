//
//  commonAddMob.m
//  ToPeso
//
//  Created by Archie Angeles on 29/10/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "commonAddMob.h"


#import "DFPBannerView.h"
#import "GADRequest.h"

@implementation commonAddMob



+ (GADBannerView *)ImplementBaner:(UITableViewController *)tableView
{
    GADBannerView *xBan = [[GADBannerView alloc]init];
    
    xBan.adUnitID = @"ca-app-pub-1492629769877969/5454029335";
    xBan.rootViewController = tableView;
    
    //simulator
    GADRequest *request = [GADRequest request];
    request.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID,nil];
    
    [xBan loadRequest:request];
    
    return  xBan;
}

@end
