//
//  SASCalculator.m
//  Hesap Makinesi
//
//  Created by Şakir Şensoy on 17/06/14.
//  Copyright (c) 2014 Şakir Şensoy. All rights reserved.
//

#import "SASCalculator.h"

@implementation SASCalculator

// constructor metodumuz
- (id) init
{
    // base objemizin init metodu bize objemizi döner ve
    // böylece obje üzerinde işlem yapabiliriz
    if (self = [super init])
    {
        // varsayılan değerler
        self.number1 = @0;
        self.number2 = @0;
        self.process = nil;
    }
    
    return self;
}

// sıfırla
- (void) cancel
{
    // değerleri sıfırla
    self.number1 = @0;
    self.number2 = @0;
    self.process = nil;
}

// sonuç
- (NSNumber *) result
{
    // result
    double _result = 0;
    
    // sayılar ve işlem operatörü yoksa nil dön
    if ( [self.number1 isEqual: @0] || [self.number2  isEqual: @0] || self.process == nil )
    {
        return nil;
    }
    
    // toplama
    if ([self.process isEqual:@"+"])
    {
        _result = [self.number1 doubleValue] + [self.number2 doubleValue];
    }
    
    // çıkarma
    if ([self.process isEqual:@"-"])
    {
        _result = [self.number1 doubleValue] - [self.number2 doubleValue];
    }
    
    // bölme
    if ([self.process isEqual:@"/"])
    {
        _result = [self.number1 doubleValue] / [self.number2 doubleValue];
    }
    
    // çarpma
    if ([self.process isEqual:@"x"])
    {
        _result = [self.number1 doubleValue] * [self.number2 doubleValue];
    }
    
    // NSNumber'ın numberWithDouble adlı metodu
    // double değişken ile bir NSNumber oluşturmamıza imkan verir
    return [NSNumber numberWithDouble:_result];
}

@end
