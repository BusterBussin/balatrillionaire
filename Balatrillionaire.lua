SMODS.Atlas {
    key = "Balatrillionaire",
    pool = {"Joker"},
    unlocked = true,
    path = "Balatrillionaire.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "jokerofgreed",
    loc_txt = {
        name = "Joker of Greed",
        text = {
            "{C:mult}+0.2 {} Mult for every {C:chips}$5 {}, on top of 1x"
        },
    },
    config = {
        -- Base multiplier for each $5 spent
        extra = {
            per5 = 0.2
        }
    },
    loc_vars = function(self, info_queue, card)
        -- Returns a table where #1# in loc_txt references the per5 multiplier
        return { vars = { card.config.extra.per5 } }
    end,
    rarity = 2,
    atlas = "Balatrillionaire",
    pos = { x = 0, y = 0 },
    cost = 5,
    calculate = function(self, card, context)
        if context.joker_main then
            -- Determine how many $5 increments were spent
            local increments = math.floor(context.chips / 5)  -- assumes context.chips is the amount spent
            local added_mult = increments * card.config.extra.per5

            return {
                mult_mod = added_mult,
                -- Localized message, using the per5 value
                message = localize { 
                    type = "variable", 
                    key = "a_mult", 
                    vars = { added_mult } 
                }
            }
        end
    end,
}
