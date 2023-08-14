// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import <Foundation/Foundation.h>
#import "CGCard.h"

@interface CGDeck : NSObject
//  Add card to the deck, in the default atTop = NO
- (void)addCard:(CGCard *)card;
- (void)addCard:(CGCard *)card atTop:(BOOL)atTop;
//  Return a random card from the deck, and remove it
- (CGCard *)drawRandomCard;

@end


