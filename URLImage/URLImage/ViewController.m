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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [txtURL resignFirstResponder];
    
    [self LoadImage:self];
        return NO;
}
-(void)LoadImageViewFunction:(NSString *) stringURL
{
    //NSURL * imageURL = [NSURL URLWithString:@"http://www.jooja.com/wp-content/uploads/2010/02/111dm.jpg"];
    NSURL * imageURL = [NSURL URLWithString:stringURL];    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    [imageKo setImage:image];
}

-(IBAction)LoadImage:(id)sender
{
        //imageKo.image = image;
    
    
    NSString *url = txtURL.text;
    
    [self LoadImageViewFunction:url];
    
    

    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [txtURL setDelegate:self ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
