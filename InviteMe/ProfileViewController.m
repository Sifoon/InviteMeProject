//
//  ProfileViewController.m
//  InviteMe
//
//  Created by Sifon on 28/11/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "SingletonClass.h"
#import "InviteMe-Bridging-Header.h"
//#import "SphereMenu.swift"

#define CUSTOM_BUTTON_ID 100

@implementation ProfileViewController



- (void)viewDidLoad {
    
    
   
     [super viewDidLoad];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];

    
    
    self.view.frame = CGRectMake(0, 0, 480, 240);
    self.view.backgroundColor = [UIColor whiteColor];
    DCPathButton *dcPathButton = [[DCPathButton alloc]
                                  initDCPathButtonWithSubButtons:6
                                  totalRadius:65
                                  centerRadius:30
                                  subRadius:30
                                  centerImage:@"MenuButtonPSD"
                                  centerBackground:nil
                                  subImages:^(DCPathButton *dc){
                                      [dc subButtonImage:@"saveIcon" withTag:0];
                                      //[dc subButtonImage:@"custom_2" withTag:1];
                                      [dc subButtonImage:@"tt" withTag:2];
                                      [dc subButtonImage:@"inviteFriendsIcon" withTag:3];
                                      [dc subButtonImage:@"AboutUsIcon" withTag:4];
                                      [dc subButtonImage:@"HowtoUseIcon" withTag:5];
                                  }
                                  subImageBackground:nil
                                  inLocationX:0 locationY:0 toParentView:self.view];
    dcPathButton.delegate = self;

    
   // radius = 130;
   // bubbleRadius = 40;

  //  _element =[[NSMutableArray alloc] initWithObjects:@"invitemelogo",@"background",@"appbar.location.checkin", nil ];
  //  _element0 =[[NSMutableArray alloc] initWithObjects:@"expandGlyph", nil ];
    
    

   // SphereMenu() *menu1 = [[SphereMenu(startPoint: CGPointMake(100, 320), startImage: start!, submenuImages:images) alloc]  init];
    
   
    
    PFUser *user =[PFUser currentUser];
    
    NSDictionary *profil=user[@"profile"];
    
    _fbid=profil[@"facebookId"];
    
    
    //    // audio play ___________________
    //    NSString *soundPath =[[NSBundle mainBundle] pathForResource:@"right_answer" ofType:@"mp3"];
    //    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    //
    //    NSError *error = nil;
    //    self.theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
    //    [self.theAudio play];
    //
    //    // _________________________
    
       
    
    
   
    
    
   
   

    
    //menuuu mdawarr bel faza
    
//    NSArray *images = @[[UIImage imageNamed:@"petal-twitter.png"],[UIImage imageNamed:@"FacebookFriends.png"],[UIImage imageNamed:@"petal-email.png"],[UIImage imageNamed:@"logoutButton.png"]];
//    
//    
//    self.menu = [[FAFancyMenuView alloc] init];
//    self.menu.delegate = self;
//    self.menu.buttonImages = images;
//    [self.view addSubview:self.menu];
    
    
//    
//    NSDictionary *profile = _user[@"profile"];
//    
//    
//    
//    NSString *name=profile[@"name"];
//    NSString *location=_user[@"locationName"];
//    NSString *email=profile[@"email"];
//    
//    
//    
//    _Nametxt.text=name;
//    _locationTxt.text=location;
//    _emailTxt.text=email;
//    _txtphone.text=_user[@"number"];
//
//
    


//    _element =[[NSMutableArray alloc] initWithObjects:@"invitemelogo",@"background",@"appbar.location.checkin", nil ];
//    _element0 =[[NSMutableArray alloc] initWithObjects:@"expandGlyph", nil ];
//    
   
    
//    menu = SphereMenu(startPoint: CGPointMake(100, 320), startImage: start!, submenuImages:images)
//    menu.delegate = self
//    self.view.addSubview(menu)
//   
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    //NSMutableArray *allocations=[[NSMutableArray alloc]init];
    
    [super viewDidAppear:animated];
   
    //  [ self zoomToUser];
    
    
    
        
    
        //_friendImage.profileID = profile[@"facebookId"];
        
    
    
    
        PFUser *curenuser=[PFUser currentUser];
        NSDictionary *profil = curenuser[@"profile"];
        _Nametxt.text=profil[@"name"];
        _locationTxt.text=curenuser[@"locationName"];
        _emailTxt.text=curenuser[@"email"];
    _txtphone.text=curenuser[@"number"];
        self.fbPicView.profileID = profil[@"facebookId"];
    
    
    
    
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}



//- (void)fancyMenu:(FAFancyMenuView *)menu didSelectedButtonAtIndex:(NSUInteger)index{
//    NSLog(@"%lu",(unsigned long)index);
//    if(index==3)
//    {
//        // Logout user, this automatically clears the cache
//        [PFUser logOut];
//        
//      
//        
//        
//        NSLog(@"logout clicked");
//        NSString * storyboardName = @"Main";
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
//        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"MainPageId"];
//        
//        [self presentViewController:vc animated:YES completion:nil];
//        
//        
//        
//        
//    }
//    if (index==1) {
//        // if there is a selected user, seed the dialog with that user
//        NSDictionary *parameters = self.fbidSelection ? @{@"to":self.fbidSelection} : nil;
//        [FBWebDialogs presentRequestsDialogModallyWithSession:nil
//                                                      message:@"Hey Join Us on InviteMe!"
//                                                        title:@"Invite a Friend"
//                                                   parameters:parameters
//                                                      handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
//                                                          if (result == FBWebDialogResultDialogCompleted) {
//                                                              NSLog(@"Web dialog complete: %@", resultURL);
//                                                          } else {
//                                                              NSLog(@"Web dialog not complete, error: %@", error.description);
//                                                          }
//                                                      }
//                                                  friendCache:self.friendCache
//         ];
//         }
//}
//



- (void)viewDidUnload {
      [super viewDidUnload];
}


#pragma mark - DCPathButton delegate

- (void)button_0_action{
    NSLog(@"Button Press Tag 0!!");
    [[PFUser currentUser] setObject:_txtphone.text forKey:@"number"];
    
    [[PFUser currentUser] saveInBackground];
    [[PFUser currentUser] setObject:_emailTxt.text forKey:@"email"];
    
    [[PFUser currentUser] saveInBackground];
   }

- (void)button_1_action{
   NSLog(@"Button Press Tag 1!!");
}

- (void)button_2_action{
    NSLog(@"Button Press Tag 2!!");
   //  Logout user, this automatically clears the cache
            [PFUser logOut];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
//            NSLog(@"logout clicked");
//            NSString * storyboardName = @"Main";
//            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
//            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"MainPageId"];
//    
//            [self presentViewController:vc animated:YES completion:nil];
    

}

- (void)button_3_action{
    // if there is a selected user, seed the dialog with that user
    NSDictionary *parameters = self.fbidSelection ? @{@"to":self.fbidSelection} : nil;
    [FBWebDialogs presentRequestsDialogModallyWithSession:nil
                                                  message:@"Hey Join Us on InviteMe!"
                                                    title:@"Invite a Friend"
                                               parameters:parameters
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (result == FBWebDialogResultDialogCompleted) {
                                                          NSLog(@"Web dialog complete: %@", resultURL);
                                                      } else {
                                                          NSLog(@"Web dialog not complete, error: %@", error.description);
                                                      }
                                                  }
                                              friendCache:self.friendCache
     ];

    NSLog(@"Button Press Tag 3!!");
    
}

- (void)button_4_action{
   NSLog(@"Button Press Tag 4!!");
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"AboutUs"];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)button_5_action{
    
    
   NSLog(@"Button Press Tag 5!!");
    
   
}

- (void)keyboardDidShow:(NSNotification *)note
{
    /* move your views here */
}

@end
