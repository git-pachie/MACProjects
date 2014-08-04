//
//  AddProductViewController.h
//  ProductViewer
//
//  Created by pachie on 3/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModalViewControllerDelegate <NSObject>

 -(void)shouldChangeNumber;

@end



@interface AddProductViewController : UIViewController

- (IBAction)done:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *category;
@property (weak, nonatomic) IBOutlet UITextField *productName;
@property (weak, nonatomic) IBOutlet UITextField *sellingPrice;

@property (nonatomic,assign) id <ModalViewControllerDelegate> delegate1;



- (IBAction)doneDed:(id)sender;

@end
