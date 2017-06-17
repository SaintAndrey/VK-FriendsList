//
//  ViewController.m
//  VK FriendsList
//
//  Created by Andrey on 06/06/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController()


@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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

- (IBAction)requestVK:(id)sender {
    [_vkLogin resignFirstResponder];
    [_vkPassword resignFirstResponder];
    
    BOOL right = YES;
    
    if ([[_vkLogin text] isEqualToString:@""]) {
        [_alertLogin setHidden:NO];
        NSLog(@"Введите логин");
        right = NO;
    }
    
    if ([[_vkPassword text] isEqualToString:@""]) {
        [_alertPassword setHidden:NO];
        NSLog(@"Введите пароль");
        right = NO;
    }
    
    if (right) {
        NSString *vk = [NSString stringWithFormat:@"https://oauth.vk.com/token?grant_type=password&client_id=3140623&client_secret=VeWdmVclDCtn6ihuP1nt&username=%@&password=%@", [_vkLogin text], [_vkPassword text]];
        NSLog(@"%@", vk);
    }
//    NSURL *urlVK = [NSURL URLWithString:vk];
//    NSURLRequest *requestVK = [NSURLRequest requestWithURL:urlVK];
//    NSString *request = [requestVK ]
}

- (IBAction)tapOnEdit:(id)sender {
    [_alertLogin setHidden:YES];
    [_alertPassword setHidden:YES];
}

@end
