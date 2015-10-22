//
//  ProfileDetailsFromTag.h
//  InviteMe
//
//  Created by Sifon on 12/12/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>
@interface ProfileDetailsFromTag : UIViewController
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilepic;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtlocation;
@property (strong, nonatomic) IBOutlet UITextField *txtPhoneNum;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;

@property(strong,nonatomic) PFUser *user;
- (IBAction)BackButton:(id)sender;

@end
