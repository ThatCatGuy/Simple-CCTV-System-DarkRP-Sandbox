include( "shared.lua" )

local viewWidth, viewHeight = 512, 300
local mat = CreateMaterial( "terminal_mat", "UnlitGeneric", { } )

function ENT:Initialize()
	self.Enabled = true
	self.rt = GetRenderTarget("terminal_view_" .. self:EntIndex(), 512, 512)
end

function ENT:Think()
	if !self.Enabled then return end

	local feed = self:GetCCTVCamera()
	if !IsValid( feed ) then
		self.HasFeed = false
		self:SetNextClientThink(CurTime() + 0.5)
		return true
	end

	if !self.HasFeed then
		self.HasFeed = true
	end

	render.PushRenderTarget(self.rt, 0, 0, viewWidth, viewHeight)
		render.Clear( 0, 0, 0, 0)
		render.RenderView( {
			origin = feed:LocalToWorld( Vector( 7, 0, 0 ) ),
			angles = feed:LocalToWorldAngles( Angle( 0, 0, 0 ) ),
			x = 0, y = 0,
			w = viewWidth, h = viewHeight,
			fov = 70,

			dopostprocess = false,
			drawhud = false,
			drawmonitors = false,
			drawviewmodel = false
		} )
	render.PopRenderTarget()
	self:SetNextClientThink(CurTime() + 0.5)
	return true
end

net.Receive("Terminal.Toggle", function()
	local terminal = net.ReadEntity()
	terminal.Enabled = true
end)

function ENT:Draw()
    self:DrawModel()

    local Pos = self:GetPos()
    local Ang = self:GetAngles()
	local dist = Pos:DistToSqr(LocalPlayer():GetPos())
	if (dist > 230000) then return end

	local pos = self:LocalToWorld( Vector( 6.1, -27.9, 35.3 ) )
	local ang = self:LocalToWorldAngles( Angle( 0, 90, 90 ) )
	local scale = 0.109

	cam.Start3D2D( pos, ang, scale )

		surface.DrawRect( 0, 0, viewWidth, viewHeight )
			if self.HasFeed then
				mat:SetTexture("$basetexture", self.rt)
				surface.SetDrawColor( 255, 255, 255, 255 )
				surface.SetMaterial( mat )
				surface.DrawTexturedRectUV(
					0, 0, viewWidth, viewHeight, 
					0, 0, 
					math.min( viewWidth / self.rt:GetMappingWidth(), 1 ), 
					math.min( viewHeight / self.rt:GetMappingHeight(), 1 )
				)
			else
				draw.SimpleText("NO CAMERA FOUND", "DermaLarge", viewWidth / 2, viewHeight / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		surface.DrawCircle( viewWidth - 20, 20, math.sin( CurTime() ) * 10, Color( 255, 0, 0 ) )
		draw.SimpleText(
			os.date("%d/%m/%Y %A %H:%M", os.time()),
			"DermaDefault",
			7.5, 5,
			Color( 255, 255, 255, 255 ),
			TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	cam.End3D2D()
end