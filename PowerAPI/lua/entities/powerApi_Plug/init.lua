AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')
 
function ENT:Initialize()
 
	self:SetModel( "models/props_lab/tpplug.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
 
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

	timer.Create("PowerAPI_PlugDespawn" .. self:EntIndex() , self.PowerAPI_DespawnDelay , 0 , function() self:QuestionLifeChoices() end) -- Every second, check if there is an owner.
end
 
function ENT:Use( activator, caller )
    -- do nothinh
end
 
function ENT:Think()
	-- don't do much
end

function ENT:QuestionLifeChoices()
	if(!IsValid(self.PowerAPI_Appliance)) then
		self:Remove()
	end
end

function ENT:OnRemove()
	timer.Remove("PowerAPI_PlugDespawn" .. self:EntIndex())
	if(self.PowerAPI_Socket) then
		self.PowerAPI_Socket.PowerAPI_Plug = nil -- Remove this from the socket so other things can use it
	end
end

function ENT:PowerAPI_OnPlugIn()
	-- Function called when plugged in
	print("Plug: PluggedIn")
end

function ENT:PowerAPI_OnUnplug()
	-- Function called when UnPlugged
	print("Plug: Unplugeed")
end