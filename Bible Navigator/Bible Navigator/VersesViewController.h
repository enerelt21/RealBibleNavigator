//
//  VersesViewController.h
//  Bible Navigator
//
//  Created by Bat-Erdene, Ene on 5/23/19.
//  Copyright © 2019 Bat-Erdene, Ene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bible.h"
#import "ChaptersViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VersesViewController : UITableViewController
@property (strong, nonatomic) Bible *bookTitle;
@property (strong, nonatomic) NSString *chapterNumber;
@property (strong, nonatomic) NSString *verseNumbers;
@property (strong, nonatomic) NSString *nameKey;
@property (strong, nonatomic) NSDictionary *bible;

@end

NS_ASSUME_NONNULL_END
