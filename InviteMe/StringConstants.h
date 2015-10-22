//
//  Constants.h
//  MessageBarManagerDemo
//
//  Created by Terry Worona on 5/16/13.
//  Copyright (c) 2013 Terry Worona. All rights reserved.
//

#define localize(key, default) NSLocalizedStringWithDefaultValue(key, nil, [NSBundle mainBundle], default, nil)

#pragma mark - Message Bars

#define kStringMessageBarErrorTitle localize(@"message.bar.error.title", @"Error ")
#define kStringMessageBarErrorMessage localize(@"message.bar.error.message", @"Fail to add a new program! please try again later")
#define kStringMessageBarSuccessTitle localize(@"message.bar.success.title", @"New program added successfully")
#define kStringMessageBarSuccessMessage localize(@"message.bar.success.message", @"You just added a new Program! Enjoy it")
#define kStringMessageBarInfoTitle localize(@"message.bar.info.title", @"Information Title")
#define kStringMessageBarInfoMessage localize(@"message.bar.info.message", @"This is an info message!")

#pragma mark - Buttons

#define kStringButtonLabelSuccessMessage localize(@"button.label.success.message", @"Success Message")
#define kStringButtonLabelErrorMessage localize(@"button.label.error.message", @"Error Message")
#define kStringButtonLabelInfoMessage localize(@"button.label.info.message", @"Information Message")
#define kStringButtonLabelHideAll localize(@"button.label.hide.all", @"Hide All")
