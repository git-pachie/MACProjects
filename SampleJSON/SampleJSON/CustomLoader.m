//
//  CustomLoader.m
//  SampleJSON
//
//  Created by pachie on 10/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "CustomLoader.h"

@implementation CustomLoader


-(void)InitializeLoader: (UITableViewController * ) table
{
    CGRect loadingSize = CGRectMake((table.view.bounds.size.width-120)/2, (table.view.bounds.size.height-170) / 2, 120, 100);
    CGRect loadingSizeInd = CGRectMake((table.view.bounds.size.width-120)/2, (table.view.bounds.size.height-160) / 2-24, 120, 100);
    CGRect loadingSizeLabel = CGRectMake((table.view.bounds.size.width - 65)/2-4, (table.view.bounds.size.height-120) / 2, 120, 100);
    
    self.xview = [[UIView alloc]initWithFrame:loadingSize];
    [self.xview setBackgroundColor:[UIColor grayColor]];
    
    self.xview.layer.cornerRadius = 8;
    self.xview.layer.masksToBounds = YES;
    self.xview.alpha = 0.9;
    self.xview.tag = 1;
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.spinner.frame = loadingSizeInd;
    self.label.text = @"Loading...";
    self.label = [[UILabel alloc] initWithFrame:loadingSizeLabel];
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont boldSystemFontOfSize:18];
    self.label.alpha = 0.8;
    self.label.tag = 1;
    
    self.spinner.tag = 1;
}

-(void)HideLoading:(UITableViewController * ) table : (dispatch_queue_t) mainQue
{
    
    sleep(1);
    
    dispatch_async(mainQue,^{
        
        //table.n.navigationItem.title = @"Home";
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false ;
        
        [self.spinner stopAnimating];
        
        for (UIView *subview in [table.view subviews]) {
            // Only remove the subviews with tag not equal to 1
            if (subview.tag == 1) {
                [subview removeFromSuperview];
            }
        }
    });
}


@end
