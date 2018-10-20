AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')
 
function ENT:Initialize()
 
	self:SetModel( "models/props_lab/reciever01a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	
	self:SetUseType( SIMPLE_USE )

	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

	-- Initialise PowerAPI
	timer.Create("PowerAPI_Applience" .. self:EntIndex() , self.DespawnDelay , 0 , function() self:DoesPlugExist() end) -- Every second, check if there is a plug.
	self:PowerAPI_MakePlug()


end
 
function ENT:Use( activator, caller )
	if ( !activator.IsPlayer() ) then return end

	if(self:PowerAPI_HasPower()) then
		print( self.PowerAPI_Plug:GetPower() .. "Watts")
	end

end
 
function ENT:Think()
    -- We don't need to think, we are just a prop after all!
end

function ENT:PowerAPI_HasPower()
	local result = false
	if(self.PowerAPI_Plug:GetPower() > 0) then
		result = true
	end

	return result
end

function ENT:Remove()
	self.PowerAPI_Plug:Remove()
end

function ENT:PowerAPI_MakePlug()
	plug = ents.Create("powerApi_Plug")
	plug:SetPos( self:GetPos() + Vector(0,20,0) )
	plug:Spawn()
	--plug:SetParent(self)

	constraint.Rope( 
		self, 	-- 	Entity 1
		plug, 	-- 	Entity 2
		0,0, 	-- 	Ignore, For ragdolls
		Vector(-7.5,8,0.25),--	Local pos on Entity 1
		Vector(12,0,0),--	Local pos on Entity 2
		96,		-- Rope length
		0,		-- Added Length
		0,		-- Force To Break
		1,		-- Width
		"cable/rope",	-- Material
		false		-- Rigid
	)

	plug.PowerAPI_Appliance = self

	self.PowerAPI_Plug = plug
end

function ENT:DoesPlugExist()
	if(!IsValid(self.PowerAPI_Plug)) then
		self:PowerAPI_MakePlug()
	end
end

function ENT:OnRemove()
	timer.Remove("PowerAPI_Applience" .. self:EntIndex())
end