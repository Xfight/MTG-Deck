//
//  CardExpansion.h
//  MTG Deck
//
//  Created by Luca Bertani on 16/05/11.
//  Copyright (c) 2011 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card, Expansion;

@interface CardExpansion : NSManagedObject {
@private
}
@property (nonatomic, retain) Card * Card;
@property (nonatomic, retain) Expansion * Expansion;

@end
