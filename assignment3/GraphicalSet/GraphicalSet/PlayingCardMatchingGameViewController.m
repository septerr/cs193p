//
//  MatchingGameViewController.m
//  GraphicalSet
//
//  Created by septerr on 5/19/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "PlayingCardMatchingGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"
#import "PlayingCardCollectionViewCell.h"
#import "PlayingCard.h"

@implementation PlayingCardMatchingGameViewController

#define STARTING_CARD_COUNT 12
#define MATCH_COUNT 2
#define MATCH_BONUS 4
#define PENALTY 2
#define FLIP_COST 1

- (Deck *) createDeck{
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *) createGameWithDeck:(Deck *)deck{
return  [[CardMatchingGame alloc] initWithCardCount:STARTING_CARD_COUNT usingDeck:deck matchCardCount:MATCH_COUNT matchBonus:MATCH_BONUS penalty:PENALTY andFlipCost:FLIP_COST];
}

- (void) updateCell:(UICollectionViewCell *)cell withCard:(Card *)card{//abstract
    if([cell isKindOfClass:[PlayingCardCollectionViewCell class]]
       && [card isKindOfClass:[PlayingCard class]]
       ){
        PlayingCardCollectionViewCell *playingCardCell = ((PlayingCardCollectionViewCell *)cell) ;
        PlayingCard *playingCard = (PlayingCard *)card;
        [playingCardCell updateView:playingCard];
    }
}

- (void) removeUnplayableCells{
    //do nothing. Overriding super's default behavior.
}
    

@end
