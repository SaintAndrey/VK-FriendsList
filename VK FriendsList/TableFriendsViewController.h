//
//  TableFriendsViewController.h
//  VK FriendsList
//
//  Created by Andrey on 16/06/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableFriendsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableFriends;

@end
