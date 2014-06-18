//
//  SASCalculator.h
//  Hesap Makinesi
//
//  Created by Şakir Şensoy on 17/06/14.
//  Copyright (c) 2014 Şakir Şensoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SASCalculator : NSObject

// Props
@property (strong, nonatomic) NSNumber *number1;
@property (strong, nonatomic) NSNumber *number2;
@property (strong, nonatomic) NSString *process;

// Methods
- (void) cancel;
- (NSNumber *) result;

@end
