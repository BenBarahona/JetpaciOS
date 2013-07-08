//
//  Util.h
//  JetpaciOS
//
//  Created by Escolarea on 7/3/13.
//  Copyright (c) 2013 Escolarea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+ (NSString *)formatStringForHUD:(NSInteger)number;
+ (void) saveHighScore:(NSUInteger)highScore;
+ (NSUInteger) loadHighScore;
@end
