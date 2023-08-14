// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "cardView.h"

@interface PlayingCardView : cardView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

@end

