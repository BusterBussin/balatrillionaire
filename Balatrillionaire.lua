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
    cost       = 20,
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
    rarity     = 3,
    cost       = 8,
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
