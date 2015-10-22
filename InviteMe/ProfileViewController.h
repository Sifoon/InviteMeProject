//
//  ProfileViewController.h
//  InviteMe
//
//  Created by Sifon on 28/11/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAFancyMenuView.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>
#import "DCPathButton.h"





@interface ProfileViewController : UIViewController<DCPathButtonDelegate>

@property (nonatomic, strong) FAFancyMenuView *menu;
@property(nonatomic,strong) NSString *fbid;
@property (readwrite, nonatomic, copy) NSString *fbidSelection;
@property (readwrite, nonatomic, retain) FBFrictionlessRecipientCache *friendCache;

@property(strong,nonatomic) PFUser *user;

@property (strong, nonatomic) IBOutlet FBProfilePictureView *fbPicView;

@property (strong, nonatomic) IBOutlet UITextField *Nametxt;
@property (strong, nonatomic) IBOutlet UITextField *locationTxt;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UITextField *txtphone;

@property(strong , nonatomic) NSMutableArray *element;
@property(strong , nonatomic) NSMutableArray *element0;






@end
