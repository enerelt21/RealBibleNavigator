//
//  ChaptersViewController.h
//  Bible Navigator
//
//  Created by Bat-Erdene, Ene on 5/23/19.
//  Copyright © 2019 Bat-Erdene, Ene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bible.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChaptersViewController : UITableViewController
@property (strong, nonatomic) Bible *bookTitle;
@property (strong, nonatomic) NSArray *chapterNumbers;
@property (strong, nonatomic) NSString *nameKey;

@end

NS_ASSUME_NONNULL_END
