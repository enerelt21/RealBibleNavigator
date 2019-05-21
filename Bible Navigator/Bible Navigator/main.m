//
//  main.m
//  Bible Navigator
//
//  Created by Bat-Erdene, Ene on 5/21/19.
//  Copyright © 2019 Bat-Erdene, Ene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        /*NSString *urlString = @"https://www.dropbox.com/s/y24kzlvu1lh5f12/BibleJson.json?dl=1";
         NSURL *url = [NSURL URLWithString: urlString];
         [[NSURLSession.sharedSession dataTaskWithURL: url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
         NSString *book = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         NSLog(@"Book Information: %@", book);
         NSError *er;
         NSDictionary *Bible = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
         if (er)
         {
         NSLog(@"The process of getting bible verses failed: %@", er);
         return;
         }
         
         for (NSDictionary *diffBook in Bible)
         {
         NSString *name = diffBook[@"name"];
         NSLog(@"%@", name);
         }
         
         
         }] resume];
         
        NSData *bookData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"https://www.dropbox.com/s/y24kzlvu1lh5f12/BibleJson.json?dl=1"]];
        NSError *err;
        NSDictionary *Bible = [NSJSONSerialization JSONObjectWithData:bookData options:NSJSONReadingAllowFragments error:&err];
        if (err)
        {
            NSLog(@"The process of getting bible verses failed: %@", err);
        }
        NSLog(@"%@", Bible);
        */
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
