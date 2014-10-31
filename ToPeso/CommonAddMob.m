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

{
    GADBannerView *_bannerView;

}




+ (GADBannerView *)ImplementBaner:(UITableViewController *)tableView
{
    GADBannerView *xBan = [[GADBannerView alloc]init];
    
    xBan.adUnitID = admobID ;
    xBan.rootViewController = tableView;
    
    //simulator
    GADRequest *request = [GADRequest request];
    
    if ([isSimulator isEqualToString:@"YES"]) {
        
        
        request.testDevices = @[ @"e14a75ec5cbe72c69e54d47a8aecb2ea" ];
        request.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID,nil];
    }
    
    
    [xBan loadRequest:request];
    
    return  xBan;
}



- (GADBannerView *)ImplementBanerBottom:(UIViewController *)uiviewController
{
    
    if (_bannerView != nil) {
        return _bannerView;
        
    }
    
    _bannerView = [[GADBannerView alloc]init];
    
    _bannerView.adUnitID = @"ca-app-pub-1492629769877969/5454029335";
    _bannerView.rootViewController = uiviewController;
    
    //simulator
    GADRequest *request = [GADRequest request];
    
    if ([isSimulator isEqualToString:@"YES"]) {
        
        request.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID,nil];
    }
    
    
    CGRect loadingSize = CGRectMake(0, 0  , (uiviewController.view.bounds.size.width), 50);
    
    _bannerView.frame = loadingSize;
    
    [_bannerView loadRequest:request];
    
    
    return  _bannerView;
}






@end
