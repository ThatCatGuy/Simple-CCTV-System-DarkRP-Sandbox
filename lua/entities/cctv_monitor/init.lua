AddCSLuaFile 'cl_init.lua'
AddCSLuaFile 'shared.lua'
include 'shared.lua'

function ENT:Initialize()
	self:SetModel( "models/props_phx/rt_screen.mdl" )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	self:PhysWake()

	local owner = self.dt.owning_ent
	if owner then
		self:CPPISetOwner(owner)
		for k, v in pairs(ents.FindByClass("cctv_camera")) do
			if v:CPPIGetOwner() == owner then
				self:SetCCTVCamera(v)
			end
		end
	end
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end
end

util.AddNetworkString("Terminal.Toggle")
function ENT:Use(ply)
	net.Start("Terminal.Toggle")
		net.WriteEntity(self)
	net.Send(ply)
end