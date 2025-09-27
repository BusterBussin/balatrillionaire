SMODS.Atlas{
    key  = "trillion_balatrillionaire",
    path = "Balatrillionaire.png",
    px   = 71,
    py   = 95,
}

SMODS.Joker{
    key        = "trillion_jokerofgreed",
    atlas      = "trillion_balatrillionaire",
    rarity     = 3,
    cost       = 10,
    pos = {x = 0, y = 0},
    discovered = true,
    spawnable  = true,
    blueprint_compat = false,

    loc_txt = {
        name = "Joker of Greed",
        text = {
            "Multiplies mult by {C:mult}+0.2{} for every {C:money}$5{} you have."
        }
    },

    calculate = function(self, card, context)
        -- fires after all scoring jokers when the final mult is about to be applied
        if context.joker_main then
            local dollars = G.GAME.dollars or 0
            local steps   = math.floor(dollars / 5)
            if steps > 0 then
                -- x_mult_mod multiplies the *final* mult by this value
                return {
                    x_mult_mod = 1 + 0.2 * steps
                }
            end
        end
    end
}


SMODS.Joker{
    key        = "trillion_equalexchange",
    atlas      = "trillion_balatrillionaire",
    pos        = { x = 1, y = 0 },
    rarity     = 4,
    cost       = 20,
    discovered = true,
    spawnable  = true,
    blueprint_compat = true,

    loc_txt = {
        name = "Equal Exchange",
        text = {
            "For each Ace played, quadruples your {C:mult}multiplier{},",
            "but costs {C:money}$10{} for each Ace."
        }
    },

    calculate = function(self, card, context)
        if context.joker_main then
            local ace_count = 0
            for _, c in ipairs(context.scoring_hand or {}) do
                -- Ace has ID 14
                if c.get_id and c:get_id() == 14 then
                    ace_count = ace_count + 1
                end
            end

            if ace_count > 0 then
                -- subtract money directly (allows negative)
                G.GAME.dollars = (G.GAME.dollars or 0) - (10 * ace_count)

                -- quadruple mult per Ace
                return {
                    x_mult_mod = 4 ^ ace_count,
                    message    = "Equal Exchange!"
                }
            end
        end
    end
}

SMODS.Joker{ --Infinite Wealth
    key = "trillion_infinitewealth",
    atlas = "trillion_balatrillionaire",
    config = {
        extra = {
            dollars = 5
        }
    },
    loc_txt = {
        ['name'] = 'Infinite Wealth',
        ['text'] = {
            [1] = 'The {C:red}fuck{} should I know how this {C:hearts}tangly{}-ass{C:dark_edition} rainbow{} shit works'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 0
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,

    calculate = function(self, card, context)
        if context.playing_card_added  then
                return {
                    dollars = card.ability.extra.dollars
                }
        end
    end
}
