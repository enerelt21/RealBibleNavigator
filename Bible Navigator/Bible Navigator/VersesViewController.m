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
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Verses"];
}
-(void) gtData{
        for (int i=0; i<[self.bible count]; i++)
        {
            //NSMutableArray *tempChapters = [NSMutableArray new];
            NSString *temp = [NSString stringWithFormat:@"%i", i+1];
            NSDictionary *arrayResult = self.bible[temp];
            
            Bible *tempBible = [Bible.new autorelease];
            tempBible.name = [arrayResult objectForKey:@"name"];
            if (![tempBible.name isEqualToString:self.bookTitle.name])
            {
                //NSLog(@"%@   %@", tempBible.name, self.bookTitle.name);
                continue;
            }
            NSDictionary *chap = [NSDictionary.new autorelease];
            chap = [arrayResult objectForKey:@"chapters"];
            self.verseNumbers = [NSString.new autorelease];
            self.verseNumbers = [chap objectForKey: self.chapterNumber];
            break;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
   // }] resume];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.verseNumbers integerValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Verses" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@:%ld", self.bookTitle.name, self.chapterNumber, (long)indexPath.row + 1];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES ];
    NSString *parse = @"olivetree://bible/%@.%@.%ld";
    NSString * urlString = [NSString stringWithFormat:parse, self.nameKey ,self.chapterNumber, (long)indexPath.row + 1];
    NSURL *url = [NSURL URLWithString:urlString];
    UIApplication *application = [[UIApplication sharedApplication] autorelease];
    [application openURL:url options:@{} completionHandler:nil];
}
@end
