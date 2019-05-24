//
//  ChaptersViewController.m
//  Bible Navigator
//
//  Created by Bat-Erdene, Ene on 5/23/19.
//  Copyright © 2019 Bat-Erdene, Ene. All rights reserved.
//

#import "ChaptersViewController.h"
#import "Bible.h"
#import "VersesViewController.h"

@interface ChaptersViewController ()

@end

@implementation ChaptersViewController
-(IBAction)gobackToThisChapterViewController:(UIStoryboardSegue *)sender{
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chapterNumbers = NSMutableArray.new;
    [self gtData];

    self.navigationItem.title = @"Chapters";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Numbers"];
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
            self.chapterNumbers = NSArray.new;
            self.chapterNumbers = [[chap allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                if ([obj1 integerValue] > [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                
                if ([obj1 integerValue] < [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
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
    return self.chapterNumbers.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Numbers" forIndexPath:indexPath];
    
    NSString *chapNumber = self.chapterNumbers[indexPath.row];
    cell.textLabel.text = chapNumber;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES ];
    VersesViewController *verseController = [[VersesViewController alloc] initWithStyle:UITableViewStylePlain];
    verseController.bookTitle = self.bookTitle;
    verseController.chapterNumber = self.chapterNumbers[indexPath.row];
    verseController.nameKey = self.nameKey;
    [[self navigationController] pushViewController:verseController animated:YES];
}
@end
