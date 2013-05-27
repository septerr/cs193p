//
//  SetSymbol.h
//  Matchismo
//
//  Created by septerr on 4/30/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetSymbol : NSObject
@property NSString *symbol;
+ (SetSymbol *)circle;
+ (SetSymbol *)square;
+ (SetSymbol *)triangle;
@end
