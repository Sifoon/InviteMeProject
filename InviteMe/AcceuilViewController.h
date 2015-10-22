//
//  AcceuilViewController.h
//  InviteMe
//
//  Created by Sifon on 13/11/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FAFancyMenuView.h"

#import <Foundation/Foundation.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)



@interface AcceuilViewController : UIViewController< UITableViewDataSource,UITableViewDelegate,FBFriendPickerDelegate>


@property (strong, nonatomic) IBOutlet UILabel *namecurrentUser;
@property (strong, nonatomic) IBOutlet UILabel *lastTagname;




@property (strong, nonatomic) IBOutlet UIImageView *ImagePhotoDeProfile;

@property(strong,nonatomic) PFGeoPoint *currentlocationUser ;


@property (strong, nonatomic) IBOutlet UIImageView *ImageDeProfilButton;



@property(strong,nonatomic) UIImageView *fbprofilPicture;




@property  (strong,nonatomic) NSArray* listTag;
@property  (strong,nonatomic) NSArray* listProfil;

@property (strong, nonatomic) IBOutlet UITableView *tagTable;

//@property (strong, nonatomic) IBOutlet UITableView *adsTable;
//@property  (strong,nonatomic) NSArray* listOfAds;

@end

