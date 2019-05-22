//
//  Bible.h
//  Bible Navigator
//
//  Created by Bat-Erdene, Ene on 5/21/19.
//  Copyright © 2019 Bat-Erdene, Ene. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chapters.h"

NS_ASSUME_NONNULL_BEGIN

@interface Bible : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *chapter;

@end

NS_ASSUME_NONNULL_END
