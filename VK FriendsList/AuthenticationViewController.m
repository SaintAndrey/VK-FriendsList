//
//  AuthenticationViewController.m
//  VK FriendsList
//
//  Created by Andrey on 30/06/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import "AuthenticationViewController.h"

@interface AuthenticationViewController () <UIWebViewDelegate>

@end

@implementation AuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *auth = @"https://oauth.vk.com/authorize?client_id=6076026&response_type=token&revoke=1&scope=friends";
    NSURL *urlAuth = [NSURL URLWithString:auth];
    NSURLRequest *requestAuth = [NSURLRequest requestWithURL:urlAuth];
    [_oauthWebView loadRequest:requestAuth];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString = request.URL.absoluteString;
    NSLog(@"%@", urlString);
    if ([urlString hasPrefix:@"https://oauth.vk.com/blank.html#access_token="]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSInteger begin = 45;
        NSInteger end = [urlString rangeOfString:@"&expires_in="].location;
        NSRange range = NSMakeRange(begin, end-begin);
        NSString *token = [urlString substringWithRange:range];
        [userDefaults setObject:token forKey:@"token"];
        [self performSegueWithIdentifier:@"showTableView" sender:self];
        NSLog(@"%@", token);
        return NO;
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
