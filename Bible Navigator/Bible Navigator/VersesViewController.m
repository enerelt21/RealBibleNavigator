//
//  VersesViewController.m
//  Bible Navigator
//
//  Created by Bat-Erdene, Ene on 5/23/19.
//  Copyright © 2019 Bat-Erdene, Ene. All rights reserved.
//

#import "VersesViewController.h"

@interface VersesViewController ()
/*
@property (strong, nonatomic) NSMutableArray<Bible *> *bookTitles;
@property (strong, nonatomic) NSMutableArray<NSArray *> *chapterNumbers;
@property (strong, nonatomic) NSMutableArray *verseNumbers;*/
@end

@implementation VersesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.bookTitles = [NSMutableArray<Bible *> new];
    [self gtData];
    //Bible *bookTitle = Bible.new;
    //have to put the data from the JSON HERE
    
    //[self.bookTitles addObject:bookTitle];
    self.navigationItem.title = @"Verses";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    //self.tableViewData = [NSDictionary dictionaryWithObjectsAndKeys: self.bookTitles, @"Section1", self.chapterNumbers, @"Section2", self.verseNumbers, @"Section3", nil];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Verses"];
}
-(void) gtData{
    /* NSString *path = [[NSBundle mainBundle] pathForResource:@"BibleJson" ofType:@"json"];
     NSString *jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
     
     NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
     NSError *jsonError;
     NSData *bookData = [[NSData alloc] initWithContentsOfFile:@"../../../BibleJson.json"];
     NSDictionary *allKeys = [NSJSONSerialization JSONObjectWithData:bookData options:NSJSONReadingAllowFragments error:&jsonError];
     
     NSLog(@"%@", allKeys);*/
    
    NSLog(@"Getting the names");
    NSURL *url = [NSURL URLWithString: @"https://www.dropbox.com/s/y24kzlvu1lh5f12/BibleJson.json?dl=1"];
    [[NSURLSession.sharedSession dataTaskWithURL: url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //NSString *book = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"Book Information: %@", book);
        NSError *er;
        NSDictionary *bible = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
        if (er)
        {
            NSLog(@"The process of getting bible verses failed: %@", er);
            return;
        }
        
        
        //NSLog(@"%@", bible);
        // Bible *bookTitle = Bible.new;
        
        //Bible *tempBible = Bible.new;
        //NSMutableArray <Bible *> *tempStore = [NSMutableArray<Bible *> new];
        //self.bookTitles = [NSMutableArray<Bible *> new];
        //NSMutableArray <NSDictionary *> *tempChapters = [NSMutableArray<NSDictionary *> new];
        for (int i=0; i<[bible count]; i++)
        {
            //NSMutableArray *tempChapters = [NSMutableArray new];
            NSString *temp = [NSString stringWithFormat:@"%i", i+1];
            NSDictionary *arrayResult = bible[temp];
            
            Bible *tempBible = Bible.new;
            tempBible.name = [arrayResult objectForKey:@"name"];
            if (tempBible.name != self.bookTitle.name)
                continue;
            
            NSDictionary *chap = NSDictionary.new;
            chap = [arrayResult objectForKey:@"chapters"];
            NSString *verse = [chap objectForKey: self.chapterNumber];
            self.verseNumbers = NSMutableArray.new;
            for (int j=0;j<[verse intValue];j++)
            {
                NSString *v =[NSString stringWithFormat:@"%i", j+1];
                [self.verseNumbers addObject:v];
            }
            
           /* NSArray *tempChapters = NSArray.new;
            tempChapters = [[chap allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                if ([obj1 integerValue] > [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                
                if ([obj1 integerValue] < [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            for (int j=0;j<[tempChapters count]; j++)
            {
                NSLog(@"name:%@   chapters: %@", tempBible.name,tempChapters[j]);
            }*/
            //for (int i);
        }
        //self.bookTitles = [[NSMutableArray<Bible *> alloc] initWithArray: tempStore];
        //self.bookTitles = tempStore;
        //self.bookTitles = tempStore;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        /*
         for (NSDictionary *book in bible)
         {
         NSString *name = [book objectForKey:@"name"];
         NSLog(@"%@", name);
         //bookTitle.name = book[@"name"];
         NSDictionary *tempChapter = book[@"chapters"];
         bookTitle.chapter = [tempChapter allKeys];
         bookTitle.chapNumber = [bookTitle.chapter count];
         
         Chapters *Chapter = Chapters.new;
         Chapter.name = bookTitle.name;
         
         [self.bookTitles addObject: bookTitle];
         NSLog(@"%@", bookTitle.name);*/
        //}
        
    }] resume];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    // return [self.tableViewData count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSString sectionTitle = [[NSString alloc] stringWithFor]
    //id sectionInfo = [self.tableViewData objectForKey:[NSString stringWithFormat: @"Section%ld", section+1]];
    //return [(NSDictionary *) sectionInfo count];
    return self.verseNumbers.count;
    //return 67;
}
/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
 
 }*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     if (tableView == self.bookTitles)
     {
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Titles" forIndexPath:indexPath];
     
     Bible *bookTitle = self.bookTitles[indexPath.row];
     cell.textLabel.text = bookTitle.name;
     // NSLog(@"%ld",(long)indexPath.row);
     return cell;
     
     }
     if (tableView == self.chapterNumbers)
     {
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Titles" forIndexPath:indexPath];
     
     Bible *bookTitle = self.bookTitles[indexPath.row];
     id section = [self.tableViewData objectForKey:[NSString stringWithFormat:@"Section%ld", indexPath.section + 1]];
     cell.textLabel.text = bookTitle.name;
     // NSLog(@"%ld",(long)indexPath.row);
     return cell;
     }
     if (tableView == self.verseNumbers)
     {
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Titles" forIndexPath:indexPath];
     
     Bible *bookTitle = self.bookTitles[indexPath.row];
     id section = [self.tableViewData objectForKey:[NSString stringWithFormat:@"Section%ld", indexPath.section + 1]];
     cell.textLabel.text = bookTitle.name;
     // NSLog(@"%ld",(long)indexPath.row);
     return cell;
     }*/
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Verses" forIndexPath:indexPath];
    
    NSString *verseNumber = self.verseNumbers[indexPath.row];
   // id section = [self.tableViewData objectForKey:[NSString stringWithFormat:@"Section%ld", indexPath.section + 1]];
    cell.textLabel.text = verseNumber;
    // NSLog(@"%ld",(long)indexPath.row);
    return cell;
}
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Books";
            break;
        case 1:
            return @"Chapters";
            break;
        case 2:
            return @"Verses";
            break;
        default:
            return nil;
            break;
    }
}*/
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
