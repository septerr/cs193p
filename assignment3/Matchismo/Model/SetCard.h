//
//  SetCard.h
//  Matchismo
//
//  Created by septerr on 4/23/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "Card.h"

typedef enum {
    square,
    triangle,
    circle
} SetSymbol;

typedef enum {
    one,
    two,
    three
} SetNumber;


typedef enum {
    red,
    green,
    purple
} SetColor;

typedef enum {
    solid,
    striped,
    none
} SetShading;


@interface SetCard : Card
@property (nonatomic) SetSymbol symbol;
@property (nonatomic) SetNumber number;
@property (nonatomic) SetColor color;
@property (nonatomic) SetShading shading;
- (id) initWithSymbol:(SetSymbol)symbol number:(SetNumber)number
                color:(SetColor)color andShading:(SetShading)shading;
- (NSAttributedString *) attributedContent;
@end
