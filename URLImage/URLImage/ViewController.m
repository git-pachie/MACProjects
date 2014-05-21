//
//  ViewController.m
//  URLImage
//
//  Created by pachie on 21/5/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(IBAction)LoadImage:(id)sender
{
    NSURL * imageURL = [NSURL URLWithString:@"http://www.jooja.com/wp-content/uploads/2010/02/111dm.jpg"];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    imageKo.image = image;
    
   

    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
