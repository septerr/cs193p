//
//  SetCardDeck.m
//  Matchismo
//
//  Created by septerr on 4/27/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id) init{
    self = [super init];
    for(SetSymbol symbol=0; symbol<3; symbol++){
        for(SetNumber num=0; num<3; num++){
            for(SetColor color=0; color<3; color++){
                for(SetShading shading=0; shading<3; shading++){
                    SetCard *card = [[SetCard alloc] initWithSymbol:symbol number:num color:color andShading:shading];
                    [self addCard:card atTop:YES];
                }
            }
        }
    }
    return self;
}

@end
