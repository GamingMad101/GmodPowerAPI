include('shared.lua')
 
function ENT:Draw()
    self:DrawModel()
    --[[cam.Start3D2D( self.GetPos() , self.GetRot() ,1 )
        draw.DrawText( self.PowerAPI_Plug:GetPower() , "DermaDefault" , 0,0, Color(255,255,255), TEXT_ALIGN_LEFT )
    cam.End3D2D()]]--
end

