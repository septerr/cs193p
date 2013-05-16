//
//  LastPlayStatus.m
//  Matchismo
//
//  Created by septerr on 5/9/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "LastPlayStatus.h"
#import "Card.h"

@implementation LastPlayStatus

-(id) initWithCard:(Card*)card otherCards:(NSArray*)otherCards status:(PlayStatus)status andScore:(NSInteger)score{
    self = [super init];
    if(self){
        if(!card)
            return nil;
        self.card = card;
        self.otherCards = (otherCards?otherCards:[[NSArray alloc]init]);
        self.status = status;
        self.score = score;
    }
    return self;
}

+ (id) matched: (Card*)card with:(NSArray*)cards forScore:(NSInteger)score{
    return [[LastPlayStatus alloc] initWithCard:card otherCards:cards status:match andScore:score];
}

+ (id) misMatched: (Card*)card andOtherCards:(NSArray*)cards forpenalty:(NSInteger)penalty{
    return [[LastPlayStatus alloc] initWithCard:card otherCards:cards status:nomatch andScore:penalty];
}

+ (id) flippedUp:(Card*)card forCost:(NSInteger)cost{
    return [[LastPlayStatus alloc] initWithCard:card otherCards:[[NSArray alloc]init] status:flipup andScore:cost];
}

+ (id) flippedDown:(Card*)card{
    return [[LastPlayStatus alloc] initWithCard:card otherCards:[[NSArray alloc]init] status:flipdown andScore:0];
}

+ (id) noPlay:(Card*)card{
    return [[LastPlayStatus alloc] initWithCard:card otherCards:[[NSArray alloc]init] status:noplay andScore:0];
}

@end
