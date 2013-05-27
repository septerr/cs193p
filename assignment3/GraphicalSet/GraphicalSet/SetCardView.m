//
//  SetCardView.m
//  GraphicalSet
//
//  Created by septerr on 5/20/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "SetCardView.h"
#import "SetCard.h"

@implementation SetCardView

//cell size: 95 x 80

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self pushContext];
 //card
    UIColor *backgroundColor = self.faceUp?[UIColor colorWithRed:1 green:0.988235 blue:0.498039 alpha:1]
                                          :[UIColor colorWithRed:0.988235 green:0.921568 blue:0.713725 alpha:1];
    [backgroundColor setFill];
    [[UIColor colorWithRed:0.941176 green:0.658823 blue:0.188235 alpha:1] setStroke];
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:12.0];
    [roundedRect addClip];
    [roundedRect fill];

 //inset
    float insetx = self.bounds.size.width * 0.1;
    float insety = self.bounds.size.height * 0.1;
    float innerRectWidth = self.bounds.size.width - 2 * insetx;
    float innerRectHeight = self.bounds.size.height - 2 * insety;
    CGRect innerRectBounds = CGRectMake(self.bounds.origin.x + insetx, self.bounds.origin.y + insety, innerRectWidth, innerRectHeight);
    
    [self drawSymbolsInRect:innerRectBounds];

   
    [self popContext];
 
}

- (void) drawSymbolsInRect:(CGRect)rect{
    float insetx = rect.size.width * 0.06;
    float insety = rect.size.height * 0.05;
    float symbolWidth = rect.size.width/4;
    float symbolHeight = rect.size.height;

    CGPoint startingPoint = self.number==one? CGPointMake(rect.origin.x + symbolWidth + insetx*2, rect.origin.y + insety)
    :self.number==two? CGPointMake(rect.origin.x + symbolWidth/2 + insetx*1.5, rect.origin.y + insety)
    :CGPointMake(rect.origin.x + insetx, rect.origin.y + insety);
    
    for(int i=0; i<(self.number==one?1:self.number==two?2:3); i++){
        UIBezierPath *rect = [UIBezierPath bezierPathWithRect:CGRectMake(startingPoint.x, startingPoint.y, symbolWidth, symbolHeight-insety*2)];
        if(self.symbol == diamond){
            [self drawDiamondInRect:rect];
        }else if(self.symbol == oval){
            [self drawOvalInRect:rect];
        }else{
            [self drawSquiggleInRect:rect];
        }
        startingPoint = CGPointMake(startingPoint.x + symbolWidth + insetx, startingPoint.y);
    }
}
#define SYMBOL_LINE_WIDTH 2.5

- (void) drawDiamondInRect:(UIBezierPath *)rect{
    [self pushContext];
    [[self uiColorForSetColor:self.color] setFill];
    [[self uiColorForSetColor:self.color] setStroke];
    UIBezierPath *diamond = [[UIBezierPath alloc] init];
    [diamond setLineWidth:SYMBOL_LINE_WIDTH];
    [diamond moveToPoint:CGPointMake(rect.bounds.origin.x + rect.bounds.size.width/2, rect.bounds.origin.y)];
    [diamond addLineToPoint:CGPointMake(rect.bounds.origin.x + rect.bounds.size.width, rect.bounds.origin.y + rect.bounds.size.height/2)];
    [diamond addLineToPoint:CGPointMake(rect.bounds.origin.x + rect.bounds.size.width/2, rect.bounds.origin.y + rect.bounds.size.height)];
    [diamond addLineToPoint:CGPointMake(rect.bounds.origin.x, rect.bounds.origin.y + rect.bounds.size.height/2)];
    [diamond closePath];
    [diamond stroke];
    [self shade:diamond];
    [self popContext];
}

- (void) drawOvalInRect:(UIBezierPath *)rect{
    [self pushContext];
    [[self uiColorForSetColor:self.color] setFill];
    [[self uiColorForSetColor:self.color] setStroke];
    UIBezierPath *oval = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.bounds.origin.x, rect.bounds.origin.y, rect.bounds.size.width, rect.bounds.size.height) cornerRadius:rect.bounds.size.width/2];
    [oval setLineWidth:SYMBOL_LINE_WIDTH];
    [oval stroke];
    [self shade:oval];
    [self popContext];
}

- (void) drawSquiggleInRect:(UIBezierPath *)rect{
    [self pushContext];
    [[self uiColorForSetColor:self.color] setFill];
    [[self uiColorForSetColor:self.color] setStroke];
    UIBezierPath *squiggle = [[UIBezierPath alloc] init];
    [squiggle setLineWidth:SYMBOL_LINE_WIDTH];
    [squiggle   moveToPoint:rect.bounds.origin];
    [squiggle addCurveToPoint:CGPointMake(rect.bounds.origin.x + rect.bounds.size.width, rect.bounds.origin.y + rect.bounds.size.height) controlPoint1:CGPointMake(rect.bounds.origin.x + rect.bounds.size.width*2, rect.bounds.origin.y + rect.bounds.size.height/3) controlPoint2:CGPointMake(rect.bounds.origin.x - rect.bounds.size.width/2, rect.bounds.origin.y + rect.bounds.size.height*2/3)];
    [squiggle addCurveToPoint:rect.bounds.origin controlPoint1:CGPointMake(rect.bounds.origin.x - rect.bounds.size.width*0.6, rect.bounds.origin.y + rect.bounds.size.height*2/3) controlPoint2:CGPointMake(rect.bounds.origin.x + rect.bounds.size.width, rect.bounds.origin.y + rect.bounds.size.height *1/3)];
    [squiggle stroke];
    [self shade:squiggle];
    [self popContext];
}

- (void) shade:(UIBezierPath *)path{
    switch (self.shading) {
        case solid:
            [path fill];
            break;
        case none:
            break;
        default:
            [self pushContext];
            [path addClip];
            float stripeSpacing = path.bounds.size.height * 0.1;
            UIBezierPath *stripes = [[UIBezierPath alloc] init];
            CGPoint stripeStartPoint = CGPointMake(path.bounds.origin.x, path.bounds.origin.y + stripeSpacing);
            while(stripeStartPoint.y < path.bounds.origin.y + path.bounds.size.height){
                [stripes moveToPoint:stripeStartPoint];
                [stripes addLineToPoint:CGPointMake(path.bounds.origin.x + path.bounds.size.width, stripeStartPoint.y)];
                stripeStartPoint = CGPointMake(stripeStartPoint.x, stripeStartPoint.y + stripeSpacing);
            }
            [stripes stroke];
            [self popContext];
    }
}

- (UIColor *) uiColorForSetColor:(SetColor)setColor{
    switch(setColor){
        case red:
            return [UIColor redColor];
        case green:
            return [UIColor colorWithRed:0.031372 green:0.619607 blue:0.443137 alpha:1];
        default:
            return [UIColor colorWithRed:0.317647 green:0.266666 blue:0.372549 alpha:1];
            
    }
}

- (CGContextRef) context{
    return UIGraphicsGetCurrentContext();
}

- (void) pushContext{
    CGContextSaveGState(UIGraphicsGetCurrentContext());
}

- (void) popContext{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}


@end
