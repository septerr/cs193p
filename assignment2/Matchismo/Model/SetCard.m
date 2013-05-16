//
//  SetCard.m
//  Matchismo
//
//  Created by septerr on 4/23/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (id) initWithSymbol:(SetSymbol)symbol number:(SetNumber)number
color:(SetColor)color andShading:(SetShading)shading{
    self = [super init];
    if(self){
        _symbol = symbol;
        _number = number;
        _color = color;
        _shading = shading;
    }
    return self;
}


- (NSValue *) symbolAsNSValue{
    SetSymbol symbol = self.symbol;
    return [NSValue value:&symbol withObjCType:@encode(SetSymbol)];
}


- (NSValue *) numberAsNSValue{
    SetNumber number = self.number;
    return [NSValue value:&number withObjCType:@encode(SetNumber)];
}


- (NSValue *) colorAsNSValue{
    SetColor color = self.color;
    return [NSValue value:&color withObjCType:@encode(SetColor)];
}


- (NSValue *) shadingAsNSValue{
    SetShading shading = self.shading;
    return [NSValue value:&shading withObjCType:@encode(SetShading)];
}

- (BOOL) sameSymbols: (NSArray *)cards{
    for(SetCard *card in cards){
        if(card.symbol != self.symbol){
            return false;
        }
    }
    return true;
}

- (BOOL) uniqueSymbols: (NSArray *) cards{
    NSMutableSet *symbolSet = [[NSMutableSet alloc] initWithObjects:[self symbolAsNSValue], nil];
    for(SetCard *card in cards){
        [symbolSet addObject: [card symbolAsNSValue]];
    }
    return [symbolSet count] == [cards count] + 1;
}


- (BOOL) sameNumbers: (NSArray *)cards{
    for(SetCard *card in cards){
        if(card.number != self.number){
            return false;
        }
    }
    return true;
}

- (BOOL) uniqueNumbers: (NSArray *) cards{
    NSMutableSet *symbolSet = [[NSMutableSet alloc] initWithObjects:[self numberAsNSValue], nil];
    for(SetCard *card in cards){
        [symbolSet addObject: [card numberAsNSValue]];
    }
    return [symbolSet count] == [cards count] + 1;
}


- (BOOL) sameColors: (NSArray *)cards{
    for(SetCard *card in cards){
        if(card.color != self.color){
            return false;
        }
    }
    return true;
}

- (BOOL) uniqueColors: (NSArray *) cards{
    NSMutableSet *symbolSet = [[NSMutableSet alloc] initWithObjects:[self colorAsNSValue], nil];
    for(SetCard *card in cards){
        [symbolSet addObject: [card colorAsNSValue]];
    }
    return [symbolSet count] == [cards count] + 1;
}


- (BOOL) sameShading: (NSArray *)cards{
    for(SetCard *card in cards){
        if(card.shading != self.shading){
            return false;
        }
    }
    return true;
}

- (BOOL) uniqueShading: (NSArray *) cards{
    NSMutableSet *symbolSet = [[NSMutableSet alloc] initWithObjects:[self shadingAsNSValue], nil];
    for(SetCard *card in cards){
        [symbolSet addObject: [card shadingAsNSValue]];
    }
    return [symbolSet count] == [cards count] + 1;
}

- (int) match:(NSArray *)otherCards{
    if(([self sameSymbols:otherCards] || [self uniqueSymbols:otherCards])
       && ([self sameNumbers:otherCards] || [self uniqueNumbers:otherCards])
       && ([self sameColors:otherCards] || [self uniqueColors:otherCards])
       && ([self sameShading:otherCards] || [self uniqueShading:otherCards]))
        return 1;
    else
        return 0;
}

- (NSAttributedString *) attributedContent{
    NSString *str;

        switch(self.symbol){
            case circle:
                str = [@"" stringByPaddingToLength:self.number+1 withString:@"●" startingAtIndex:0];
                break;
            case square:
                str = [@"" stringByPaddingToLength:self.number+1 withString:@"■" startingAtIndex:0];
                break;
            case triangle:
                str = [@"" stringByPaddingToLength:self.number+1 withString:@"▲" startingAtIndex:0];
                break;
            default:
                break;
        }

    NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];
    switch (self.color) {
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
    switch (self.shading) {
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


- (NSString *) contents{
    return [[self attributedContent ] string];
//    switch(self.symbol){
//        case square:
//            return [@"" stringByPaddingToLength:self.number+1 withString:@"●" startingAtIndex:0];
//        case triangle:
//            return [@"" stringByPaddingToLength:self.number+1 withString:@"■" startingAtIndex:0];
//        case circle:
//            return[@"" stringByPaddingToLength:self.number+1 withString:@"▲" startingAtIndex:0];
//        default:
//            return @"";
//    }
}

@end
