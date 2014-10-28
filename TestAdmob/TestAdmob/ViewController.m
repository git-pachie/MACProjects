//
//  ViewController.m
//  TestAdmob
//
//  Created by Archie Angeles on 20/10/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "ViewController.h"
#import "DFPBannerView.h"
#import "GADRequest.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Replace this ad unit ID with your own ad unit ID.
    
    //self.bannerView.frame = CGRectMake(0, 0, 50, 450);
    
    //GADAdSize size1 = GADAdSizeFromCGSize(CGSizeMake(120, 20));
    //GADAdSize size2 = GADAdSizeFromCGSize(CGSizeMake(250, 250));
    //GADAdSize size3 = GADAdSizeFromCGSize(CGSizeMake(320, 50));
    //NSMutableArray *validSizes = [NSMutableArray array];
    ////[validSizes addObject:[NSValue valueWithBytes:&size1 objCType:@encode(GADAdSize)]];
    //[validSizes addObject:[NSValue valueWithBytes:&size2 objCType:@encode(GADAdSize)]];
    //[validSizes addObject:[NSValue valueWithBytes:&size3 objCType:@encode(GADAdSize)]];
    //self.bannerView.validAdSizes = size3;
    
    //[self.bannerView setAdSizeDelegate:self];
    
     //[self.bannerView setAdSizeDelegate:self];
    
    self.bannerView.adUnitID = @"ca-app-pub-1492629769877969/5454029335";
    self.bannerView.rootViewController = self;
    GADRequest *request = [GADRequest request];
    request.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID,nil];
    
    [self.bannerView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
