local caSave = CardArea.save
function CardArea:save(cardAreaTable)
    if G.GAME.akyrs_any_drag and cardAreaTable then
        cardAreaTable.akyrs_drag_to_target_save = self.states.collide.can
    end
    return caSave(self,cardAreaTable)
end
local caLoad = CardArea.load
function CardArea:load(cardAreaTable)
    
    if G.GAME.akyrs_any_drag and cardAreaTable then
        self.states.collide.can = cardAreaTable.akyrs_drag_to_target_save
    end
    return caLoad(self,cardAreaTable)
end
local v_scu = set_consumeable_usage
function set_consumeable_usage(card)
    

    return v_scu(card)
end


function Card:akyrs_flip_y()
    if self.facing == 'front' then 
        self.flipping = 'akyrs_f2b_y'
        self.facing='back'
        self.pinch.y = true
    elseif self.facing == 'back' then
        self.ability.wheel_flipped = nil
        self.flipping = 'akyrs_b2f_y'
        self.facing='front'
        self.pinch.y = true
    end
end
-- basically function get_front_spriteinfo(_front) returns pos n shit
AKYRS.sprite_info_override = function (_center,_front, card, orig_a, orig_p)
    --if not _center or not _front then return end
    --print(card.config.center_key,_front.suit,_front.value)
    _center = _center or card.config.center
    _front = _front or card.base
    if _center.set == "Enhanced" then
        if _front.suit and card.config and _center and _center.key == "m_akyrs_rankless" then
            return AKYRS.suit_to_atlas(_front.suit)
        end
        if _front.value and card.config and _center and _center.key == "m_akyrs_suitless" then
            return AKYRS.rank_to_atlas(_front.value)
        end
    end

    return orig_a, orig_p
end


AKYRS.should_playing_card_loc_hooks = function (_c)
    if not _c then return false end
    --print(_c)
    return _c.set == "Enhanced" and (_c.key == "m_akyrs_suitless" or _c.key == "m_akyrs_rankless")
end

AKYRS.playing_card_loc_hooks = function (_c,full_UI_table,specific_vars)
    if _c.set == "Enhanced" and _c.key == "m_akyrs_suitless" then
        localize{type = 'other', key = 'akyrs_playing_card_rank', set = 'Other', nodes = full_UI_table.name, vars = {localize(specific_vars.value, 'ranks'), localize(specific_vars.suit, 'suits_plural'), colours = {specific_vars.colour}}}
    end
    if _c.set == "Enhanced" and _c.key == "m_akyrs_rankless" then
        localize{type = 'other', key = 'akyrs_playing_card_suit', set = 'Other', nodes = full_UI_table.name, vars = {localize(specific_vars.value, 'ranks'), localize(specific_vars.suit, 'suits_plural'), colours = {specific_vars.colour}}}
    end
end

AKYRS.should_score_chips = function (_c)
    --print(_c)
    if _c.set == "Enhanced" and _c.key == "m_akyrs_rankless" then
        return false
    end
    return true
end