SMODS.Rarity{
    key = "supercommon",
    default_weight = 0.3,
    badge_colour = HEX('8c94a3'),
    pools = {
        ["Joker"] = true
    },
    get_weight = function(self, weight, object_type)
        return (G.GAME and next(SMODS.find_card("j_akyrs_emerald"))) and 0.45 or 0.1
    end,

}