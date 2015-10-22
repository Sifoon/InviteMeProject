//
//  SignInViewController.m
//  InviteMe
//
//  Created by Sifon on 14/11/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import "SignInViewController.h"
#import "SCImagePicker.h"



@interface SignInViewController ()<SCImagePickerDelegate>

@property (nonatomic, strong) SCImagePicker *imagePicker;
@property (nonatomic, strong) UIImage *selectedPhoto;


@end
//static int const MIN_USER_GENERATED_PHOTO_DIMENSION = 480;


@implementation SignInViewController

- (void)viewDidLoad {
    UIImage *background = [UIImage imageNamed: @"background.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
    
    [self.view addSubview: imageView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)setImagePicker:(SCImagePicker *)imagePicker
{
    if (_imagePicker != imagePicker) {
        _imagePicker.delegate = nil;
        _imagePicker = imagePicker;
    }
}


- (void)setSelectedPhoto:(UIImage *)selectedPhoto
{
    if (![_selectedPhoto isEqual:selectedPhoto]) {
        _selectedPhoto = selectedPhoto;
        self.photoView.image = selectedPhoto;
    }
}

#pragma mark - View Management

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
}

- (IBAction)pickImage:(id)sender {
    
    SCImagePicker *imagePicker = [[SCImagePicker alloc] init];
    self.imagePicker = imagePicker;
    imagePicker.delegate = self;
    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) && [sender isKindOfClass:[UIView class]]) {
        UIView *senderView = (UIView *)sender;
        UIView *view = self.view;
        [imagePicker presentFromRect:[view convertRect:senderView.bounds fromView:senderView] inView:self.view];
    } else {
        [imagePicker presentWithViewController:self];
    }
    
    [self saveNewUser];

}





#pragma mark - SCImagePickerDelegate

- (void)imagePicker:(SCImagePicker *)imagePicker didSelectImage:(UIImage *)image
{
    self.selectedPhoto = image;
    self.imagePicker = nil;
}

- (void)imagePickerDidCancel:(SCImagePicker *)imagePicker
{
    self.imagePicker = nil;
}


-(void) saveNewUser
{
    
}

@end
