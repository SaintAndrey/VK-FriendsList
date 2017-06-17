//
//  ViewController.h
//  VK FriendsList
//
//  Created by Andrey on 06/06/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *vkLogin;
@property (weak, nonatomic) IBOutlet UITextField *vkPassword;
@property (weak, nonatomic) IBOutlet UILabel *alertLogin;
@property (weak, nonatomic) IBOutlet UILabel *alertPassword;

- (IBAction)backgroundTap:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)requestVK:(id)sender;
- (IBAction)tapOnEdit:(id)sender;

@end

