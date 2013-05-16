//
//  PlayingCard.h
//  Matchismo
//
//  Created by septerr on 4/9/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (nonatomic, strong) NSString *suit;
@property (nonatomic) NSUInteger rank;
+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;
@end
