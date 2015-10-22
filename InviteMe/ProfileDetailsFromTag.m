//
//  ProfileDetailsFromTag.m
//  InviteMe
//
//  Created by Sifon on 12/12/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import "ProfileDetailsFromTag.h"
#import "SingletonClass.h"

@implementation ProfileDetailsFromTag


-(void)viewDidLoad
{
    
    
    [super viewDidLoad];

    
    SingletonClass* sharedSingletonn = [SingletonClass sharedUserProgramCreatorTag];
    PFObject *obj = [sharedSingletonn userOfProgramCreatorTag];
    _user=obj[@"user"];
    
    
    
    NSLog(@"%@ ttttttttttt",obj);
    
    NSDictionary *profi=obj[@"profile"];
    
    NSString *name=profi[@"name"];
    
    NSString *number=obj[@"number"];
    NSString *email=obj[@"email"];
    
    NSString *location=obj[@"locationName"];
    
    
       
    NSLog(@"%@",profi[@"name"]);
    NSLog(@"%@",name);
    NSLog(@"%@",name);
    NSLog(@"%@",name);
    NSLog(@"%@",name);
    
    
    
    _txtName.text=name;
    _txtlocation.text=location;
    _txtPhoneNum.text=number;
    _txtEmail.text=email;
    
    
    self.profilepic.profileID=profi[@"facebookId"];
    
//    
//    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] init];
//    [tapRecognizer addTarget:self action:@selector(bigButtonTapped:)];
//    [self.ButonPhotoDeProfil addGestureRecognizer:tapRecognizer];
//    [self.ButonPhotoDeProfil setAccessibilityLabel:@"Photo of a cat wearing a Bane costume."];
//    self.ButonPhotoDeProfil.layer.cornerRadius = self.ButonPhotoDeProfil.bounds.size.width/2.0f;
}


- (IBAction)BackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
