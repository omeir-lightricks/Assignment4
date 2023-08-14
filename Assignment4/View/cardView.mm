// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "cardView.h"

@implementation cardView

- (void)setChosen:(BOOL)chosen {
  _chosen = chosen;
  [self setNeedsDisplay];
}

@end

