//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by septerr on 4/9/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (id) init{
    self = [super init];
    for(NSString *suit in [PlayingCard validSuits]){
        for(NSUInteger rank=1; rank<=[PlayingCard maxRank]; rank++){
            PlayingCard *card = [[PlayingCard alloc] init];
            [card setSuit: suit];
            [card setRank: rank];
            [self addCard:card atTop:YES];
        }
    }
    return self;
}

@end
