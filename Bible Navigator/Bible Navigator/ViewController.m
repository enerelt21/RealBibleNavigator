//
//  ViewController.m
//  Bible Navigator
//
//  Created by Bat-Erdene, Ene on 5/21/19.
//  Copyright © 2019 Bat-Erdene, Ene. All rights reserved.
//

#import "ViewController.h"
#import "Bible.h"
#import "Chapters.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray<Bible *> *bookTitles;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //self.bookTitles = [NSMutableArray<Bible *> new];
    [self gtData];
    //Bible *bookTitle = Bible.new;
    //have to put the data from the JSON HERE
    
    //[self.bookTitles addObject:bookTitle];
    self.navigationItem.title = @"Books";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Titles"];
    
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
     self.bookTitles = [NSMutableArray<Bible *> new];
     for (int i=0; i<[bible count]; i++)
     {
         Bible *tempBible = Bible.new;
         NSString *temp = [NSString stringWithFormat:@"%i", i+1];
         NSDictionary *arrayResult = bible[temp];
         tempBible.name = [arrayResult objectForKey:@"name"];
         NSLog (@"%@", tempBible.name);
         [self.bookTitles addObject:tempBible];
     }
         //self.bookTitles = [[NSMutableArray<Bible *> alloc] initWithArray: tempStore];
         //self.bookTitles = tempStore;
         for (int i=0; i<[self.bookTitles count]; i++)
         {
             NSLog(@"%@", self.bookTitles[i].name);
         }
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
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bookTitles.count;
    //return 67;
}
/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
}*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Titles" forIndexPath:indexPath];
    
    Bible *bookTitle = self.bookTitles[indexPath.row];
    cell.textLabel.text = bookTitle.name;
    // NSLog(@"%ld",(long)indexPath.row);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

@end
