//
//  Card.m
//  Matchismo
//
//  Created by septerr on 4/7/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int) match:(NSArray *)otherCards{
    int score = 0;
    for(Card *card in otherCards){
        if([card.contents isEqualToString: self.contents]){
            score = 1;
        }
    }
    return score;
}
@end
