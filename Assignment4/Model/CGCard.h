// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import <Foundation/Foundation.h>

@interface CGCard : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

//  Return the score of matching the card with few other cards
- (int)match:(NSArray *)otherCards;

- (void)setIsChosen:(BOOL)isChosen;

- (void)setMatched:(BOOL)isMatched;

@end

