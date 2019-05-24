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
    NSLog(@"Getting the names");
    NSURL *url = [NSURL URLWithString: @"https://www.dropbox.com/s/y24kzlvu1lh5f12/BibleJson.json?dl=1"];
    [[NSURLSession.sharedSession dataTaskWithURL: url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *er;
        NSDictionary *bible = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
        if (er)
        {
            NSLog(@"The process of getting bible verses failed: %@", er);
            return;
        }
        for (int i=0; i<[bible count]; i++)
        {
            //NSMutableArray *tempChapters = [NSMutableArray new];
            NSString *temp = [NSString stringWithFormat:@"%i", i+1];
            NSDictionary *arrayResult = bible[temp];
            
            Bible *tempBible = Bible.new;
            tempBible.name = [arrayResult objectForKey:@"name"];
            if (![tempBible.name isEqualToString:self.bookTitle.name])
            {
                //NSLog(@"%@   %@", tempBible.name, self.bookTitle.name);
                continue;
            }
            NSDictionary *chap = NSDictionary.new;
            chap = [arrayResult objectForKey:@"chapters"];
            NSString *verse = [chap objectForKey: self.chapterNumber];
            self.verseNumbers = NSMutableArray.new;
            for (int j=0;j<[verse intValue];j++)
            {
                NSString *v =[NSString stringWithFormat:@"%i", j+1];
                [self.verseNumbers addObject:v];
            }
            break;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }] resume];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.verseNumbers.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Verses" forIndexPath:indexPath];
    
    NSString *verseNumber = self.verseNumbers[indexPath.row];
    cell.textLabel.text = verseNumber;
    // NSLog(@"%ld",(long)indexPath.row);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES ];
    NSString *parse = @"olivetree://bible/%@.%@.%@";
    NSString * urlString = [NSString stringWithFormat:parse, self.nameKey ,self.chapterNumber, self.verseNumbers[indexPath.row]];
   // NSLog(@"%@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    UIApplication *application = [UIApplication sharedApplication];
    [application openURL:url options:@{} completionHandler:nil];
}
@end
