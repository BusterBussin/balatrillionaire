SMODS.Atlas{
    key  = "trillion_balatrillionaire",
    path = "Balatrillionaire.png",
    px   = 71,
    py   = 95,
}

SMODS.Joker{
    key        = "trillion_jokerofgreed",
    atlas      = "trillion_balatrillionaire",
    rarity     = 1,
    cost       = 2,
    discovered = true,
    spawnable  = true,

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
