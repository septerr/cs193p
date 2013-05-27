//
//  SetCardCollectionViewCell.m
//  GraphicalSet
//
//  Created by septerr on 5/20/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "SetCardCollectionViewCell.h"

@implementation SetCardCollectionViewCell

- (CardView *) cardView{
    return self.setCardView;
}
- (void)updateView:(Card *)card{
    if([card isKindOfClass:[SetCard class]]){
        SetCard *setCard = (SetCard *) card;
        SetCardView *setCardView = self.setCardView;
        BOOL needsUpdate = setCardView.symbol != setCard.symbol
        || setCardView.color != setCard.color
        || setCardView.number != setCard.number
        || setCardView.shading != setCard.shading
        || setCardView.faceUp != setCard.faceUp;
        if(needsUpdate){
            setCardView.symbol = setCard.symbol;
            setCardView.color = setCard.color;
            setCardView.number = setCard.number;
            setCardView.shading = setCard.shading;
            setCardView.faceUp = setCard.faceUp;
            [setCardView setNeedsDisplay];
        }
    }
}

@end
