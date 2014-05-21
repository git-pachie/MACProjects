//
//  CoreDataViewController.m
//  CoreData
//
//  Created by pachie on 20/5/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "CoreDataViewController.h"
#import "AppDelegate.h"

@interface CoreDataViewController ()

@end

@implementation CoreDataViewController


- (IBAction)saveData:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context =  [appDelegate managedObjectContext];
    NSManagedObject *newContact;
    
    newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Contacts"
                  inManagedObjectContext:context];
    
    [newContact setValue: _name.text forKey:@"name"];
    [newContact setValue: _address.text forKey:@"address"];
    [newContact setValue: _phone.text forKey:@"phone"];
    _name.text = @"";
    _address.text = @"";
    _phone.text = @"";
    NSError *error;
    [context save:&error];
    _status.text = @"Contact saved";
}



- (IBAction)findContact:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context =   [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc =    [NSEntityDescription entityForName:@"Contacts"   inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(name = %@)", _name.text];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    if ([objects count] == 0) {
        _status.text = @"No matches";
    } else {
        matches = objects[0];
        _address.text = [matches valueForKey:@"address"];
        _phone.text = [matches valueForKey:@"phone"];
        _status.text = [NSString stringWithFormat:@"%lu matches found", (unsigned long)[objects count]];
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
