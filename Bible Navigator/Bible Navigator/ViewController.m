//
//  ViewController.m
//  Bible Navigator
//
//  Created by Bat-Erdene, Ene on 5/21/19.
//  Copyright © 2019 Bat-Erdene, Ene. All rights reserved.
//

#import "ViewController.h"
#import "Bible.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray<Bible *> *bookTitles;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self gtData];
    self.bookTitles = NSMutableArray.new;
    Bible *bookTitle = Bible.new;
    //have to put the data from the JSON HERE
    
    [self.bookTitles addObject:bookTitle];
    self.navigationItem.title = @"Books";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Key"];
    
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
     NSString *book = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     NSLog(@"Book Information: %@", book);
     NSError *er;
     NSDictionary *bible = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
     if (er)
     {
     NSLog(@"The process of getting bible verses failed: %@", er);
     return;
     }
     
     }] resume];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bookTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Key" forIndexPath:indexPath];
    
    Bible *bookTitle = self.bookTitles[indexPath.row];
    cell.textLabel.text = bookTitle.name;
    return cell;
}
@end
