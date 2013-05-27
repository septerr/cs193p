//
//  LastPlayStatus.h
//  Matchismo
//
//  Created by septerr on 5/9/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

typedef enum {
    match,
    nomatch,
    flipup,
    flipdown,
    noplay
} PlayStatus;

@interface LastPlayStatus : NSObject
@property (nonatomic, strong) Card *card;
@property (nonatomic, strong) NSArray *otherCards;
@property (nonatomic) NSInteger score;
@property (nonatomic) PlayStatus status;
+ (id) matched: (Card*)card with:(NSArray*)cards forScore:(NSInteger)score;
+ (id) misMatched: (Card*)card andOtherCards:(NSArray*)cards forpenalty:(NSInteger)penalty;
+ (id) flippedUp:(Card*)card forCost:(NSInteger)cost;
+ (id) flippedDown:(Card*)card;
+ (id) noPlay:(Card*)card;
@end
