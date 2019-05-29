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
/*
-(NSArray *) mergeSort: (NSArray *) tempArray;
-(NSArray *) merge: (NSArray *) left: (NSArray *)right;*/
@end

@implementation ChaptersViewController
-(IBAction)gobackToThisChapterViewController:(UIStoryboardSegue *)sender{
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chapterNumbers = [NSMutableArray.new autorelease];
    [self gtData];

    self.navigationItem.title = @"Chapters";
    self.navigationController.navigationBar.prefersLargeTitles = YES;

    NSString *titles = [[[NSString alloc] initWithFormat:@"Chapters"] autorelease];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:titles];
}
-(void) gtData{

        NSDictionary *chap = [self.bible objectForKey:@"chapters"];
        self.chapterNumbers = [NSArray.new autorelease];
        self.chapterNumbers = [[chap allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
         }
                
         if ([obj1 integerValue] < [obj2 integerValue]) {
             return (NSComparisonResult)NSOrderedAscending;
         }
          return (NSComparisonResult)NSOrderedSame;
         }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chapterNumbers.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *titles = [[[NSString alloc] initWithFormat:@"Chapters"] autorelease];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: titles forIndexPath:indexPath];
    
    NSString *chapNumber = self.chapterNumbers[indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", self.bookTitle.name, chapNumber];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES ];
    VersesViewController *verseController = [[[VersesViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    verseController.bookTitle = self.bookTitle;
    verseController.chapterNumber = self.chapterNumbers[indexPath.row];
    verseController.nameKey = self.nameKey;
    verseController.bible = self.bible;
    [[self navigationController] pushViewController:verseController animated:YES];
}
-(void)dealloc
{
    self.bookTitle = nil;
    self.chapterNumbers = nil;
    self.nameKey = nil;
    self.bible = nil;
    [super dealloc];
}
@end
