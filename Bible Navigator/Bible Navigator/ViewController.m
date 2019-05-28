//
//  ViewController.m
//  Bible Navigator
//
//  Created by Bat-Erdene, Ene on 5/21/19.
//  Copyright © 2019 Bat-Erdene, Ene. All rights reserved.
//

#import "ViewController.h"
#import "ChaptersViewController.h"
#import "VersesViewController.h"
#import "Bible.h"

@interface ViewController ()

@property (strong, nonatomic) NSString *nameKey;
@property (strong, nonatomic) NSMutableArray<Bible *> *bookTitles;
@property (strong, nonatomic) NSDictionary *bible;
@end

@implementation ViewController
-(IBAction)gobackToThisViewController:(UIStoryboardSegue *)sender{
}
- (void)viewDidLoad {
    [super viewDidLoad];

    //self.bookTitles = [NSMutableArray<Bible *> new];
    [self gtData];

    self.navigationItem.title = @"Books";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Titles"];
}
-(void) gtData{
     NSLog(@"Getting the names");
     NSURL *url = [NSURL URLWithString: @"https://www.dropbox.com/s/y24kzlvu1lh5f12/BibleJson.json?dl=1"];
     [[NSURLSession.sharedSession dataTaskWithURL: url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
     //NSString *book = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     //NSLog(@"Book Information: %@", book);
     NSError *er = nil;
     self.bible = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
     if (er)
     {
     NSLog(@"The process of getting bible verses failed: %@", er);
     return;
     }
     self.bookTitles = [[NSMutableArray<Bible *> new] autorelease];
     //NSMutableArray <NSDictionary *> *tempChapters = [NSMutableArray<NSDictionary *> new];
     for (int i=0; i<[self.bible count]; i++)
     {
         //NSMutableArray *tempChapters = [NSMutableArray new];
         NSString *temp = [NSString stringWithFormat:@"%i", i+1];
         NSDictionary *arrayResult = self.bible[temp];

         Bible *tempBible = [Bible.new autorelease];
         tempBible.name = [arrayResult objectForKey:@"name"];
         [self.bookTitles addObject:tempBible];
     }
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
         });
    
     }] resume];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bookTitles.count;
    //return 67;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Titles" forIndexPath:indexPath];
    
    Bible *bookTitle = self.bookTitles[indexPath.row];
    //id section = [self.tableViewData objectForKey:[NSString stringWithFormat:@"Section%ld", indexPath.section + 1]];
    cell.textLabel.text = bookTitle.name;
    // NSLog(@"%ld",(long)indexPath.row);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES ];
    ChaptersViewController *chapController = [[[ChaptersViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    chapController.bookTitle = self.bookTitles[indexPath.row];
    self.nameKey = [NSString.new autorelease];
    self.nameKey = [NSString stringWithFormat:@"%ld", (long)indexPath.row + 1];
    chapController.nameKey = self.nameKey;
    chapController.bible = self.bible;
    [[self navigationController] pushViewController:chapController animated:YES];
}
@end
