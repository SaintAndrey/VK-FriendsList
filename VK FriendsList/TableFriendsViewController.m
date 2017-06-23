//
//  TableFriendsViewController.m
//  VK FriendsList
//
//  Created by Andrey on 16/06/2017.
//  Copyright © 2017 Andrey. All rights reserved.
//

#import "TableFriendsViewController.h"

@interface TableFriendsViewController ()
{
    NSMutableArray *friends;
    
}

@property NSUserDefaults *userDefaults;

@end

@implementation TableFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    friends = [NSMutableArray new];
    _userDefaults = [NSUserDefaults standardUserDefaults];
    
    [self requestFriends];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestFriends {
    NSString *vkFriends = [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?user_id=&v=5.52&access_token=%@&fields=name&order=name", [_userDefaults objectForKey:@"token"]];
    NSURL *vkFriendsURL = [NSURL URLWithString:vkFriends];
    NSURLSession *vkFriendsSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[vkFriendsSession dataTaskWithURL:vkFriendsURL
                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                         
                         [self parserFriends:data];
                     }] resume];
}

- (void)parserFriends:(NSData * _Nullable)data {
    NSDictionary *responseFriends = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil] objectForKey:@"response"];
    NSArray *itemFriends = [responseFriends objectForKey:@"items"];
    
    [itemFriends enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop){
        NSString *friend = [NSString stringWithFormat:@"%@ %@", [obj objectForKey:@"first_name"], [obj objectForKey:@"last_name"]];
        [friends addObject:friend];
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableFriends reloadData];
    });
    [_userDefaults setObject:nil forKey:@"token"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

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

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

/*
#pragma mark - Navigation

 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 return 1;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 return 8;
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *MyIndentifier = @"IDDQD";
 
 UITableViewCell *cell = [_m_pItemsTable dequeueReusableCellWithIdentifier:MyIndentifier];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIndentifier];
 }
 
 NSArray *temp = [[NSArray alloc] initWithObjects:@"Меркурий", @"Верера", @"Земля", @"Марс", @"Юпитер", @"Сатурн", @"Уран", @"Нептун", nil];
 
 cell.textLabel.text = [temp objectAtIndex:indexPath.row];
 
 return cell;
 }
 
 - (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 return indexPath;
 }

 
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
