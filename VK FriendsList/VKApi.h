//
//  Friends.h
//  VK FriendsList
//
//  Created by Andrey on 01/07/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const VKApiGetRequestForFriendsNotification;

extern NSString* const VKApiFriendsUserInfoKey;

@interface VKApi : NSObject

- (void)getVKFriends;

@end
