//
//  Friends.m
//  VK FriendsList
//
//  Created by Andrey on 01/07/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import "VKApi.h"

NSString* const VKApiGetRequestForFriendsNotification = @"VKApiGetRequestForFriendsNotification";

NSString* const VKApiFriendsUserInfoKey = @"VKApiFriendsUserInfoKey";

@interface VKApi () <NSURLSessionDownloadDelegate>
{
    NSMutableArray *friends;
}

@property NSUserDefaults *userDefaults;
@property(nonatomic, copy) void(^successBlock)(NSData *);

@end

@implementation VKApi

- (instancetype)init
{
    self = [super init];
    if (self) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)retrieveURL:(NSURL *)url successBlock:(void(^)(NSData *))successBlock {
    self.successBlock = successBlock;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration *conf =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:conf delegate:self delegateQueue:nil];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    
    [task resume];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    NSData *data = [NSData dataWithContentsOfURL:location];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.successBlock(data);
    });
}

- (void)getVKFriends {
    
    friends = [NSMutableArray array];
    
    NSString *vkFriends = [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?user_id=&v=5.52&access_token=%@&fields=name&order=name", [_userDefaults objectForKey:@"token"]];
    NSURL *vkFriendsURL = [NSURL URLWithString:vkFriends];
    
    [self retrieveURL:vkFriendsURL successBlock:^(NSData *data) {
        NSDictionary *responseFriends = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil] objectForKey:@"response"];
        NSArray *itemFriends = [responseFriends objectForKey:@"items"];
        
        [itemFriends enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop){
            NSString *friend = [NSString stringWithFormat:@"%@ %@", [obj objectForKey:@"first_name"], [obj objectForKey:@"last_name"]];
            [friends addObject:friend];
        }];
        
        NSDictionary *dictionaryDataForFriends = [NSDictionary dictionaryWithObject:friends forKey:VKApiFriendsUserInfoKey];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:VKApiGetRequestForFriendsNotification
                                                            object:nil
                                                          userInfo:dictionaryDataForFriends];
    }];
    
}

@end
