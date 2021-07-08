hook.Add("loadCustomDarkRPItems", "Cat_CCTV_Initialize", function()

DarkRP.createCategory{
    name = "CCTV", -- The name of the category.
    categorises = "entities", -- What it categorises. MUST be one of "jobs", "entities", "shipments", "weapons", "vehicles", "ammo".
    startExpanded = true, -- Whether the category is expanded when you open the F4 menu.
    color = Color(0, 107, 0, 255), -- The color of the category header.
    canSee = function(ply) return true end, -- OPTIONAL: whether the player can see this category AND EVERYTHING IN IT.
    sortOrder = 100, -- OPTIONAL: With this you can decide where your category is. Low numbers to put it on top, high numbers to put it on the bottom. It's 100 by default.
}

DarkRP.createEntity("CCTV Camera", {
  ent = "cctv_camera",
  model = "models/dav0r/camera.mdl",
  price = 2500,
  max = 1,
  cmd = "buyterminalcamera",
  category = "CCTV"
})

DarkRP.createEntity("CCTV Monitor", {
  ent = "cctv_monitor",
  model = "models/props_phx/rt_screen.mdl",
  price = 1000,
  max = 1,
  cmd = "buyterminal",
  category = "CCTV"
})
end)