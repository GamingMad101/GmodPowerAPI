AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')
 
function ENT:Initialize()
 
	self:SetModel( "models/props_lab/tpplugholder_single.mdl" )
	self:PhysicsInit( 	SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( 	MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( 		SOLID_VPHYSICS )         -- Toolbox
	self:SetUseType( 	SIMPLE_USE )
	self:SetTrigger(true)

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end
 
function ENT:Use( activator, caller )
	if( self.PowerAPI_Plug  ) then
		self:PowerAPI_Unplug(	self.PowerAPI_Plug	)
	end
end
 
function ENT:Think()
    -- We don't need to think... Yet
end

function ENT:StartTouch( ent )
	if(ent.PowerAPI_IsAPlug) then
		print("Plug Touched")
		self:PowerAPI_PlugIn(ent)
	end
end

function ENT:PowerAPI_PlugIn( plug )
	if( plug.PowerAPI_IsAPlug ) then
		if( !self.PowerAPI_Plug ) then
			plug:SetParent(self)
			plug:SetLocalPos(		Vector(5,13,10.1)	)
			plug:SetLocalAngles(	Angle(0,0,0)	) 
			plug.PowerAPI_Socket = self
			plug:PowerAPI_OnPlugIn()
			self.PowerAPI_Plug = plug
			print("Socket: Plugged in")
		else
			-- What to do if a plug is already in
		end
	else
		print("PowerAPI ERROR: Tried to plug in a non-plug entity.")
	end
end

function ENT:PowerAPI_Unplug(Plug)

	if(!IsValid(Plug)) then return end

	if( Plug.PowerAPI_IsAPlug ) then
		Plug:SetLocalPos(		Vector(10,13,10.1)	)
		Plug:SetLocalAngles(	Angle(0,0,0)	) 
		Plug:SetParent( nil )
		Plug.PowerAPI_Socket = nil
		Plug:PowerAPI_OnUnplug()
		self.PowerAPI_Plug = nil
		print("Socket: Unplugged")
	else
		print("PowerAPI ERROR: Tried to unplug a non-plug entity.")
	end
end