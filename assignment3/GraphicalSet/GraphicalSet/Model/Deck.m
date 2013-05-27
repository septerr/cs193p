//
//  Deck.m
//  Matchismo
//
//  Created by septerr on 4/7/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

- (NSMutableArray *) cards{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void) addCard: (Card *)card atTop: (BOOL) atTop{
    if (atTop) {
        [self.cards insertObject: card atIndex:0];
    }else{
        [self.cards addObject: card];
    }
}

- (Card *)drawRandomCard{
    Card *randomCard;
    if(self.cards.count){
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

- (NSUInteger) cardCount{
    return [self.cards count];
}

@end
