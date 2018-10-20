ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Power Plug"
ENT.Author			= "GamingMad101"
ENT.Contact			= "GamingMad101 on Steam"
ENT.Purpose			= "Provide Power"
ENT.Instructions	= "Place down and recieve power."
ENT.Category        = "PowerAPI"
ENT.Spawnable       = true
ENT.PowerAPI_DespawnDelay    = 0.2


ENT.PowerAPI_IsAPlug = true
ENT.PowerAPI_Appliance  = nil
ENT.PowerAPI_Socket  = nil

function ENT:GetPower()
	local power = self.PowerAPI_Socket.PowerAPI_Watts
	return power
end