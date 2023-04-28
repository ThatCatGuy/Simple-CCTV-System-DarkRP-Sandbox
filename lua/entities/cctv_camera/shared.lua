ENT.Type 		= "anim" 
ENT.Base		= "base_anim" 
ENT.PrintName	= "CCTV Camera"
ENT.Author		= ""
if DarkRP then
	ENT.Spawnable	= false
else
	ENT.Spawnable	= true
end
ENT.Category 	= "CCTV"
ENT.Freeze 		= true

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
end