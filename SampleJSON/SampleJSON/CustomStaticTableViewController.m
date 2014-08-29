//
//  CustomStaticTableViewController.m
//  SampleJSON
//
//  Created by pachie on 15/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "CustomStaticTableViewController.h"
#import "AppDelegate.h"
#import "CustomStringClass.h"
#import "CommonFunction.h"
#import "CommonSendRequest.h"

@interface CustomStaticTableViewController ()
{

dispatch_queue_t camerq;
    
}
@end

@implementation CustomStaticTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
   // self.lblAccountName.text = @"Free";
    //self.lblEmail.text  = delegate.EmailAddress;
    
//    NSString * urlString = [@"http://www.american.edu/uploads/profiles/large/chris_palmer_profile_11.jpg"stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
//    NSURL * imageURL = [NSURL URLWithString:urlString];
//    
//
//
//    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
//    UIImage * image = [UIImage imageWithData:imageData];
//    
//    [self.profilepic setImage:image];
    
    
    //_profilepic.contentMode = UIViewContentModeBottom;
    
    if (!camerq) {
        camerq = dispatch_queue_create("cameraQUE",NULL);
    }
    
    dispatch_async(camerq, ^{
        
        //self.profilepic.image =
        [self loadImage];
        [self ApplyCircleToImage:self.profilepic];
        
    });
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)takePhoto:(id)sender {
    
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
//    }
//    
//    // image picker needs a delegate,
//    [imagePickerController setDelegate:self];
//    
//    // Place image picker on the screen
//    
//    //[self presentModalViewController:imagePickerController animated:YES];
//    
//    [self presentViewController:imagePickerController animated:YES completion:nil];
//    
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera; imagePicker.mediaTypes = @[(NSString *) kUTTypeImage]; imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker  animated:YES completion:nil];
        _newMedia = YES;
    
    }
    
    
    
    
    
    
    

}

- (IBAction)loadExistingPhoto:(id)sender {
//    
//    UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
//    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//    
//    // image picker needs a delegate so we can respond to its messages
//    [imagePickerController setDelegate:self];
//    
//    // Place image picker on the screen
//    //[self presentModalViewController:imagePickerController animated:YES];
//    
//    [self presentViewController:imagePickerController animated:YES completion:nil];
//    
    
    
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init]; imagePicker.delegate = self; imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        _newMedia = NO;
        
        //[CommonSendRequest  SendProfileToServer:image];
    }
    
    
    
    

}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType]; [self dismissViewControllerAnimated:YES completion:nil];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        self.profilepic.image = image;
        if (_newMedia)
            
            UIImageWriteToSavedPhotosAlbum(image, self,@selector(image:finishedSavingWithError:contextInfo:), nil);
        
        //self.profilepic.image = [self loadImage];
        
        
        if (image != nil)
        {
            
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString* path = [documentsDirectory stringByAppendingPathComponent:
                              [CommonFunction ProfileImageFileName]];
            NSData* data = UIImagePNGRepresentation(image);
            [data writeToFile:path atomically:YES];
        }
        
        [CommonSendRequest  SendProfileToServer:image];
        
        [self ApplyCircleToImage:self.profilepic];
    
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        }

    
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    
//    
//        // "myImageView" name of any UIImageView.
//    
//    if (image != nil)
//    {
//        
//        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//                                                             NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString* path = [documentsDirectory stringByAppendingPathComponent:
//                          [CommonFunction ProfileImageFileName]];
//        NSData* data = UIImagePNGRepresentation(image);
//        [data writeToFile:path atomically:YES];
//    }
//    
//    self.profilepic.image = [self loadImage];
//    
//    [self ApplyCircleToImage:self.profilepic];
//    
//    
//
//}

-(void)ApplyCircleToImage : (UIView *)image
{
    dispatch_async(camerq, ^{
    
        image.layer.cornerRadius = image.frame.size.width/2;// self.profileImageView.frame.size.width / 2
        image.clipsToBounds = YES;
        image.layer.borderWidth = 4;
        image.layer.borderColor = [UIColor purpleColor].CGColor;
        
        
        
        self.btntakephoto.layer.cornerRadius = 10;
        self.btnloadexisting.alpha = 0.6;
        
        self.btnloadexisting.layer.cornerRadius= 10;
        self.btntakephoto.alpha = 0.6;
    });
    
    
}

- (void)loadImage
{
    
   
    
    dispatch_async(camerq, ^{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          [CommonFunction ProfileImageFileName]];
        UIImage* image = [UIImage imageWithContentsOfFile:path];
        //_profilepic.contentMode = UIViewContentModeCenter;
        
        //_profilepic.contentMode = UIViewContentModeScaleAspectFill;
        
        self.profilepic.image = image;
        
        [CommonSendRequest  SendProfileToServer:image];
        
        
        
    });
    
    
    
    
}
@end
