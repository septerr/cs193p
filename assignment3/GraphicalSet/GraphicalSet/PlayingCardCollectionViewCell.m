//
//  PlayingCardCollectionViewCell.m
//  GraphicalSet
//
//  Created by septerr on 5/20/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "PlayingCardCollectionViewCell.h"
#import "PlayingCard.h"

@implementation PlayingCardCollectionViewCell

- (void) setPlayingCardView:(PlayingCardView *)playingCardView{
    _playingCardView = playingCardView;
    [playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:playingCardView action:@selector(pinch:)]];
    
}

- (CardView *) cardView{
    return self.playingCardView;
}
- (void) updateView:(Card *) card{
    if([card isKindOfClass:[PlayingCard class]]){
        PlayingCard *playingCard = (PlayingCard *) card;
        PlayingCardView *playingCardView = self.playingCardView;
        BOOL needsDisplay = playingCardView.rank != playingCard.rank
        || playingCardView.suit != playingCard.suit
        || playingCardView.faceUp != playingCard.faceUp
        || playingCardView.unplayable != playingCard.unplayable;
        if(needsDisplay){
            self.playingCardView.rank = playingCard.rank;
            self.playingCardView.suit = playingCard.suit;
            self.playingCardView.faceUp = playingCard.faceUp;
            self.playingCardView.unplayable = playingCard.unplayable;
            [self.playingCardView setNeedsDisplay];
        }
    }
}

@end
