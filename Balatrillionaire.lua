SMODS.Atlas{
    key = "trillion_balatrillionaire",
    path = "Balatrillionaire.png",
    px = 71,
    py = 95,
    discovered = true,
}

SMODS.Joker{
    key = "trillion_jokerofgreed",
    atlas = "trillion_balatrillionaire",
    rarity = 1,
    cost = 2,
    discovered = true,
    spawnable = true,
    registered = true,   -- FORCE registration
    scoring = true,      -- triggers during scoring
    deck_spawn = { red = 1 },

    loc_txt = {
        name = "Joker of Greed",
        text = {"{C:mult}×0.2 {} Mult for every {C:chips}$5, applied once per scoring hand"}
    },

    calc_joker = function(self, ctx)
        if ctx.joker_main and ctx.scoring_hand then
            local dollars = G.GAME.dollars or 0
            local bonus = math.floor(dollars / 5) * 0.2
            ctx.multiply_mult = (ctx.multiply_mult or 1) * (1 + bonus)
            print("Joker of Greed triggered! Bonus mult:", bonus)  -- debug
        end
    end
}
