//
//  ProgramsViewController.h
//  InviteMe
//
//  Created by Sifon on 21/11/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ProgramsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIScreenEdgePanGestureRecognizer *swipeedge;
@property (strong, nonatomic) IBOutlet UIButton *addProgramButton;

@property (strong, nonatomic) IBOutlet UIImageView *imagePhotoDeProfil;
@property (strong, nonatomic) IBOutlet UIImageView *ButonPhotoDeProfil;
@property (strong, nonatomic) IBOutlet UILabel *nameCurrentUser;

@property (strong, nonatomic) IBOutlet UILabel *locationCurrentUser;

@property (strong, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) IBOutlet FBProfilePictureView *fbPicView;

@property (strong, nonatomic)  NSArray *listProg;

@property (strong, nonatomic)  NSArray *listLike;




@end
