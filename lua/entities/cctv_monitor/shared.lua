ENT.Type 		= "anim" 
ENT.Base		= "base_anim" 
ENT.PrintName	= "CCTV Monitor"
ENT.Author		= ""
ENT.Spawnable	= false
ENT.Category 	= "CCTV"
ENT.Freeze 		= true

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
	self:NetworkVar("Entity", 1, "CCTVCamera")
end