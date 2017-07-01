//
//  TableFriendsViewController.m
//  VK FriendsList
//
//  Created by Andrey on 16/06/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import "TableFriendsViewController.h"
#import "VKApi.h"

@interface TableFriendsViewController ()
{
    NSArray *friends;
}

@end

@implementation TableFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    VKApi *user = [[VKApi alloc] init];
    [user getVKFriends];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(friendsReceived:)
                                                 name:VKApiGetRequestForFriendsNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)friendsReceived:(NSNotification *)notification {
    NSDictionary *dicFriends = notification.userInfo;
    friends = dicFriends[VKApiFriendsUserInfoKey];
    [_tableFriends reloadData];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [friends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"IDDQD";
    
    UITableViewCell *cell = [_tableFriends dequeueReusableCellWithIdentifier:MyIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    cell.textLabel.text = [friends objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - UITableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

@end
