//
//  SetSymbol.m
//  Matchismo
//
//  Created by septerr on 4/30/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "SetSymbol.h"

@implementation SetSymbol
+ (SetSymbol *) circle{
    SetSymbol *setSymbol = [[SetSymbol alloc]init];
    setSymbol.symbol = @"●";
    return setSymbol;
}

+ (SetSymbol *) square{
    SetSymbol *setSymbol = [[SetSymbol alloc]init];
    setSymbol.symbol = @"■";
    return setSymbol;
}

+ (SetSymbol *) triangle{
    SetSymbol *setSymbol = [[SetSymbol alloc]init];
    setSymbol.symbol = @"▲";
    return setSymbol;
}

@end
