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
/*
-(NSArray *) mergeSort: (NSArray *) tempArray
{
    if (tempArray.count < 2)
        return tempArray;
    long mid = tempArray.count / 2;
    NSArray *left = [tempArray subarrayWithRange:NSMakeRange(0, mid)];
    NSArray *right = [tempArray subarrayWithRange:NSMakeRange(mid, tempArray.count - mid)];
    NSArray *finalArray = [self merge: [self mergeSort:left] : [self mergeSort:right]];
    return finalArray;
}
-(NSArray *) merge: (NSArray *) arrayLeft: (NSArray *)arrayRight
{
    NSMutableArray *finalArray = NSMutableArray.new;
    int i = 0, j = 0;
    while (i < arrayLeft.count && j < arrayRight.count)
        [finalArray addObject:([arrayLeft[i] intValue] < [arrayRight[j] intValue]) ? arrayLeft[i++] : arrayRight[j++]];
    while (i < arrayLeft.count)
        [finalArray addObject:arrayLeft[i++]];
    while (j < arrayRight.count)
        [finalArray addObject:arrayRight[j++]];
    
    return finalArray;
    
}*/
-(IBAction)gobackToThisChapterViewController:(UIStoryboardSegue *)sender{
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chapterNumbers = [NSMutableArray.new autorelease];
    [self gtData];

    self.navigationItem.title = @"Chapters";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Numbers"];
}
-(void) gtData{

        NSDictionary *chap = [NSDictionary.new autorelease];
        chap = [self.bible objectForKey:@"chapters"];

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
  //  }] resume];
    
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
@end
