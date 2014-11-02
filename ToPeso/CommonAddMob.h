//
//  commonAddMob.h
//  ToPeso
//
//  Created by Archie Angeles on 29/10/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DFPBannerView.h"
#import <UIKit/UIKit.h>


#define admobID  @"ca-app-pub-1492629769877969/5454029335"
#define isSimulator @"YES"


@interface commonAddMob : NSObject

+ (GADBannerView *)ImplementBaner:(UITableViewController *)tableView;
- (GADBannerView *)ImplementBanerBottom:(UIViewController *)uiviewController;

@end
