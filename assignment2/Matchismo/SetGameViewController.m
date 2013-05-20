//
//  SetGameViewController.m
//  Matchismo
//
//  Created by septerr on 4/23/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "CardMatchingGame.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (void) updateButton:(UIButton*)button forCard:(Card*)card{
    [button setAttributedTitle:[ ((SetCard *)card) attributedContent] forState:UIControlStateNormal];
    button.enabled = !card.isUnplayable;
    button.hidden = card.isUnplayable?YES:NO;
    button.backgroundColor = card.isFaceUp?[UIColor yellowColor]:[UIColor whiteColor];
}
- (void) updateLastPlay:(UILabel*)label forGame:(CardMatchingGame*)game{
    LastPlayStatus *lastPlayStatus = game.lastPlayStatus;
    if(lastPlayStatus){
        NSMutableAttributedString *str;
        switch(lastPlayStatus.status){
            case match:
                str = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
                [str appendAttributedString:[self attributedContentsOf:lastPlayStatus.otherCards]];
                [str appendAttributedString:[[NSAttributedString alloc] initWithString:@" and "]];
                [str appendAttributedString:[self attributedContentof:(SetCard*)lastPlayStatus.card]];
                [str appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" for %d point(s)!", lastPlayStatus.score]]];
                label.attributedText = str;
                break;
            case nomatch:
                str = [[NSMutableAttributedString alloc] initWithString:@""];
                [str appendAttributedString:[self attributedContentsOf:lastPlayStatus.otherCards]];
                [str appendAttributedString:[[NSAttributedString alloc] initWithString:@" and "]];
                [str appendAttributedString:[self attributedContentof:(SetCard*)lastPlayStatus.card]];
                [str appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" do not match! %d point penalty!", lastPlayStatus.score]]];
                label.attributedText = str;
                break;
            case flipup:
                str = [[NSMutableAttributedString alloc] initWithString:@"Flipped open "];
                [str appendAttributedString:[self attributedContentof:(SetCard*)lastPlayStatus.card]];
                label.attributedText = str;
                break;
            case flipdown:
                str = [[NSMutableAttributedString alloc] initWithString:@"Flipped over "];
                [str appendAttributedString:[self attributedContentof:(SetCard*)lastPlayStatus.card]];
                label.attributedText = str;
                break;
            case noplay:
                str = [[NSMutableAttributedString alloc] initWithString:@"Unplayable card "];
                [str appendAttributedString:[self attributedContentof:(SetCard*)lastPlayStatus.card]];
                label.attributedText = str;
                break;
        }

    }else{
        label.attributedText = [[NSAttributedString alloc] initWithString:@""];
    }
}

- (CardMatchingGame *) instantiateGameWithCardCount:(NSUInteger)count{
    return [[CardMatchingGame alloc] initWithCardCount: count usingDeck:[[SetCardDeck alloc] init] matchCardCount:3 matchBonus:8 penalty:2 andFlipCost:1];
}

- (NSAttributedString *) attributedContentsOf:(NSArray*)cards{
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc] init];
    BOOL first = YES;
    for(SetCard *card in cards){
        if(!first)
            [contents appendAttributedString:[[NSAttributedString alloc] initWithString:@", "]];
        [contents appendAttributedString:[self attributedContentof:card]];
        first = NO;
    }
    return contents;
}

- (NSAttributedString *) attributedContentof:(SetCard*)card{
    NSString *str;
    
    switch(card.symbol){
        case circle:
            str = [@"" stringByPaddingToLength:card.number+1 withString:@"●" startingAtIndex:0];
            break;
        case square:
            str = [@"" stringByPaddingToLength:card.number+1 withString:@"■" startingAtIndex:0];
            break;
        case triangle:
            str = [@"" stringByPaddingToLength:card.number+1 withString:@"▲" startingAtIndex:0];
            break;
        default:
            break;
    }
    
    NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];
    switch (card.color) {
        case red:
            attrs[NSForegroundColorAttributeName] = [UIColor redColor];
            break;
        case green:
            attrs[NSForegroundColorAttributeName] = [UIColor greenColor];
            break;
        case purple:
            attrs[NSForegroundColorAttributeName] = [UIColor purpleColor];
            break;
        default:
            break;
    }
    switch (card.shading) {
        case solid:
            attrs[NSStrokeWidthAttributeName] = [NSNumber numberWithFloat:-3.0] ;//solidfill
            break;
        case striped:
            
            attrs[NSStrokeWidthAttributeName] = [NSNumber numberWithFloat:-3.0] ;//solidfill
            attrs[NSForegroundColorAttributeName] = [((UIColor*)attrs[NSForegroundColorAttributeName]) colorWithAlphaComponent:0.5];//with alpha
            break;
            
        case none:
            attrs[NSStrokeWidthAttributeName] = @10;//nofill
            break;
        default:
            break;
    }
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:15];
    return [[NSAttributedString alloc] initWithString:str attributes:attrs];
}



@end
