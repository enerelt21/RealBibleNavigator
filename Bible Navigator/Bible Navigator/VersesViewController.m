//
//  VersesViewController.m
//  Bible Navigator
//
//  Created by Bat-Erdene, Ene on 5/23/19.
//  Copyright © 2019 Bat-Erdene, Ene. All rights reserved.
//

#import "VersesViewController.h"

@interface VersesViewController ()

@end

@implementation VersesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self gtData];
    
    self.navigationItem.title = @"Verses";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    NSString *titles = [[[NSString alloc] initWithFormat:@"Verses"] autorelease];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:titles];
}
-(void) gtData{
            NSDictionary *chap = [self.bible objectForKey:@"chapters"];
            //chap = [self.bible objectForKey:@"chapters"];
            self.verseNumbers = [[chap objectForKey: self.chapterNumber] autorelease];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.verseNumbers integerValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *titles = [[[NSString alloc] initWithFormat:@"Verses"] autorelease];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: titles forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@:%ld", self.bookTitle.name, self.chapterNumber, (long)indexPath.row + 1];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES ];
    NSString *parse = @"olivetree://bible/%@.%@.%ld";
    NSString * urlString = [NSString stringWithFormat:parse, self.nameKey ,self.chapterNumber, (long)indexPath.row + 1];
    NSURL *url = [NSURL URLWithString:urlString];
    UIApplication *application = [UIApplication sharedApplication];
    [application openURL:url options:@{} completionHandler:nil];
}
-(void)dealloc
{
    self.bookTitle = nil;
    self.chapterNumber = nil;
    self.verseNumbers = nil;
    self.nameKey = nil;
    self.bible = nil;
    [super dealloc];
}
@end
