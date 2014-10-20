//
//  ViewController.h
//  TestAdmob
//
//  Created by Archie Angeles on 20/10/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFPBannerView.h"


@protocol GADAdSizeDelegate <NSObject>
- (void)adView:(GADBannerView *)view willChangeAdSizeTo:(GADAdSize)size;
@end

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet DFPBannerView *bannerView;
@property (weak, nonatomic) id <GADAdSizeDelegate> delegate;


@end

