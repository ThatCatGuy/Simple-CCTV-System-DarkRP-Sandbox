AddCSLuaFile 'cl_init.lua'
AddCSLuaFile 'shared.lua'
include 'shared.lua'

function ENT:Initialize()
	self:SetModel( "models/dav0r/camera.mdl" )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	
	self:PhysWake()

	local owner = self.dt.owning_ent
	if owner then
		if DarkRP then
			self:CPPISetOwner(owner)
			for k, v in pairs(ents.FindByClass("cctv_monitor")) do
				if v:CPPIGetOwner() == owner then
					v:SetCCTVCamera(self)
				end
			end
		else
			for k, v in pairs(ents.FindByClass("cctv_monitor")) do
				if v:GetOwner() == owner then
					v:SetCCTVCamera(self)
				end
			end
		end
	end

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end
end