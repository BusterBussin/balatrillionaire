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


-- SMODS.Joker{ --Equal Exchange
--     key = "trillion_equalexchange",
--     config = {
--         extra = {
--             dollars = 25,
--             Xmult = 4
--         }
--     },
--     loc_txt = {
--         ['name'] = 'Equal Exchange',
--         ['text'] = {
--             [1] = 'For each{C:green} ace{} played, quadruples your{C:red} mult{}.',
--             [2] = 'Lose {C:attention}$25{} per {C:green}ace{} played,'
--         },
--         ['unlock'] = {
--             [1] = 'Unlocked by default.'
--         }
--     },
--     pos = {
--         x = 1,
--         y = 0
--     },
--     cost = 20,
--     rarity = 4,
--     blueprint_compat = false,
--     eternal_compat = true,
--     perishable_compat = true,
--     unlocked = true,
--     discovered = true,
--     atlas = 'trillion_balatrillionaire',
--     in_pool = function(self, args)
--           return (
--           not args 
--           or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rif' 
--           or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
--           )
--           and true
--       end,

--     calculate = function(self, card, context)
--         if context.individual and context.cardarea == G.play  then
--             if context.other_card:get_id() == 14 then
--                 return {
--                     dollars = -card.ability.extra.dollars,
--                     extra = {
--                         Xmult = card.ability.extra.Xmult
--                         }
--                 }
--             end
--         end
--     end
-- }

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
SMODS.Joker{ --Riff Raff but better
    key = "trillion_riffraffbutbetter",
    config = {
        extra = {
            eternal = 0,
            respect = 0,
            yes = 0,
            var1 = 0
        }
    },
    loc_txt = {
        name = 'Riff Raff but better',
        text = {
            [1] = 'Whatever, go my {C:dark_edition}Swashbucklers{}.'
        },
        unlock = { [1] = 'Unlocked by default.' }
    },
    pos = { x = 3, y = 0 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'trillion_balatrillionaire',

    calculate = function(self, card, context)
        -- only do something when setting the blind
        if context.setting_blind then
            return {
                func = function()
                    -- spawn Swashbuckler with negative edition and eternal sticker
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_swashbuckler' })
                            if joker_card then
                                joker_card:set_edition("e_negative", true)
                                joker_card:add_sticker('eternal', true)
                            end
                            return true
                        end
                    }))

                    -- find and remove Riff Raff if present
                    for _, joker in ipairs(G.jokers.cards) do
                        if joker.config.center.key == "j_riff_raff" and not joker.getting_sliced then
                            if joker.ability.eternal then
                                joker.ability.eternal = nil
                            end
                            joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    joker:start_dissolve({ G.C.RED }, nil, 1.6)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card,
                                'extra', nil, nil, nil,
                                { message = "FUCK YOU", colour = G.C.RED })
                            break
                        end
                    end

                    card_eval_status_text(context.blueprint_card or card,
                        'extra', nil, nil, nil,
                        { message = "GO MY SWASHBUCKLER", colour = G.C.BLUE })

                    return true
                end
            }
        end
    end
}
