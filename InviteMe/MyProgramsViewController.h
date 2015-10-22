//
//  MyProgramsViewController.h
//  InviteMe
//
//  Created by Sifon on 16/12/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>


@interface MyProgramsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)  NSArray *listProg;
@property (strong, nonatomic) IBOutlet UITableView *table;
- (IBAction)BackButton:(id)sender;


@end
