//
//  CountryMainTableViewController.h
//  ToPeso
//
//  Created by pachie on 12/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DFPBannerView.h"

//@protocol GADAdSizeDelegate <NSObject>
//- (void)adView:(GADBannerView *)view willChangeAdSizeTo:(GADAdSize)size;
//@end

@interface CountryMainTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic,strong)NSFetchedResultsController *fectched;

//@property (strong, nonatomic) IBOutlet GADBannerView *myBannerView;

//@property (weak, nonatomic) id <GADAdSizeDelegate> delegate;


-(void)LoadFromNotification :(NSString *)remittanceGUID;


@end
