//
//  Deck.h
//  Matchismo
//
//  Created by septerr on 4/7/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
- (void) addCard: (Card *)card atTop: (BOOL) atTop;
- (Card *) drawRandomCard;
@end
