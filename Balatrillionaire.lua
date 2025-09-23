--- STEAMODDED METADATA
--- MOD_NAME: Balatrillionaire
--- MOD_ID: balatrillionaire
--- PREFIX: trillion
--- VERSION: 1.0

-- Atlas definition
SMODS.Atlas{
    key = "trillion_balatrillionaire",
    path = "Balatrillionaire.png", -- Steamodded handles 1x/2x
    px = 71,
    py = 95,
    discovered = true,
}

-- Joker definition
SMODS.Joker{
    key = "trillion_jokerofgreed",
    atlas = "trillion_balatrillionaire",
    rarity = 1,
    cost = 2,
    discovered = true,       -- force it to show in collection
    spawnable = true,        -- allow it to spawn in runs
    deck_spawn = { red = 1 },-- define which deck pool it can spawn in
    loc_txt = {
        name = "Joker of Greed",
        text = {
            "{C:mult}+0.2 {} Mult for every {C:chips}$5 {}, on top of 1x"
        }
    },
    config = {
        extra = { per5 = 0.2 }
    },
    loc_vars = function(self, info_queue, card)
        local per5 = (card.config and card.config.extra and card.config.extra.per5) or 0
        return { vars = { per5 } }
    end,
    calculate = function(self, card, context)
    if context.joker_main then
        local chips = context.chips or 0
        local increments = math.floor(chips / 5)
        local mult_factor = 1 + (increments * ((card.config.extra and card.config.extra.per5) or 0))
        return {
            mult_mod = context.mult * mult_factor,  -- multiply the existing mult
            message = localize{
                type = "variable",
                key = "a_mult",
                vars = { mult_factor }
            }
        }
    end
end



}
