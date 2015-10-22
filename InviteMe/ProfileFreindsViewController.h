//
//  ProfileFreindsViewController.h
//  InviteMe
//
//  Created by Sifon on 05/12/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>
#import "FAFancyMenuView.h"

@interface ProfileFreindsViewController : UIViewController


@property (strong, nonatomic) IBOutlet FBProfilePictureView *fbpic;

@property (strong, nonatomic) IBOutlet UITextField *txtName;

@property (strong, nonatomic) IBOutlet UITextField *txtLocation;

@property (strong, nonatomic) IBOutlet UITextField *txtNumber;


@property(strong,nonatomic) PFUser *user;
@property (strong, nonatomic) IBOutlet UITextField *txtemail;
- (IBAction)BackButton:(id)sender;

@end
