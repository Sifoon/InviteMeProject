//
//  ProfileFreindsViewController.m
//  InviteMe
//
//  Created by Sifon on 05/12/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import "ProfileFreindsViewController.h"
#import "SingletonClass.h"

@implementation ProfileFreindsViewController
- (void)viewDidLoad {
    
    
    
    
    
    
    
    
    //    // audio play ___________________
    //    NSString *soundPath =[[NSBundle mainBundle] pathForResource:@"right_answer" ofType:@"mp3"];
    //    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    //
    //    NSError *error = nil;
    //    self.theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
    //    [self.theAudio play];
    //
    //    // _________________________
    
    
    
    
    [super viewDidLoad];
    
    
   
    
  
    
    SingletonClass* sharedSingleton = [SingletonClass sharedUserProgramCreator];
    PFObject *obj = [sharedSingleton userOfProgramCreator];
    _user=obj[@"user"];
    
    
    
    NSLog(@"%@ ttttttttttt",_user);
    
    NSDictionary *profi=_user[@"profile"];
    
    NSString *name=profi[@"name"];
    
    NSString *number=_user[@"number"];
    NSString *email=profi[@"email"];
    
    NSString *location=_user[@"locationName"];
   
    
    NSLog(@"%@",profi[@"name"]);
    NSLog(@"%@",name);
    NSLog(@"%@",name);
    NSLog(@"%@",name);
    NSLog(@"%@",name);

    
    
    _txtName.text=name;
    _txtLocation.text=location;
    _txtNumber.text=number;
    _txtemail.text=email;


    self.fbpic.profileID=profi[@"facebookId"];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //  [ self zoomToUser];
    
    
   
    
    
    
}

- (IBAction)BackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
