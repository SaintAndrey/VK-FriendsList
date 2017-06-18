//
//  ViewController.m
//  VK FriendsList
//
//  Created by Andrey on 06/06/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController()
{
    NSUserDefaults *userDefaults;
}

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    userDefaults = [NSUserDefaults standardUserDefaults];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backgroundTap:(id)sender {
    [_vkLogin resignFirstResponder];
    [_vkPassword resignFirstResponder];
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)receiveToken:(id)sender {
    [_vkLogin resignFirstResponder];
    [_vkPassword resignFirstResponder];
    BOOL right = YES;
    
    if ([[_vkLogin text] isEqualToString:@""]) {
        [_alertLogin setHidden:NO];
        right = NO;
    }
    
    if ([[_vkPassword text] isEqualToString:@""]) {
        [_alertPassword setHidden:NO];
        right = NO;
    }
    
    if (right) {
        NSString *vkAccess = [NSString stringWithFormat:@"https://oauth.vk.com/token?grant_type=password&client_id=3140623&client_secret=VeWdmVclDCtn6ihuP1nt&username=%@&password=%@", [_vkLogin text], [_vkPassword text]];
        NSURL *vkURL = [NSURL URLWithString:vkAccess];
        NSURLSession *vkSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[vkSession dataTaskWithURL:vkURL
                  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                      NSString *accessToken = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil] objectForKey:@"access_token"];
                      [userDefaults setObject:accessToken forKey:@"token"];
         }] resume];
    }
}

- (IBAction)tapOnEdit:(id)sender {
    [_alertLogin setHidden:YES];
    [_alertPassword setHidden:YES];
}

@end
