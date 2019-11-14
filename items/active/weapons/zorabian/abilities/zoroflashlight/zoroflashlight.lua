zFlashlight = WeaponAbility:new()

function zFlashlight:init()
  self:reset()
end

function zFlashlight:update(dt, fireMode, shiftHeld)
  WeaponAbility.update(self, dt, fireMode, shiftHeld)

  if self.fireMode == "alt" and self.lastFireMode ~= "alt" then
    self.active = not self.active
    animator.setLightActive("flashlight", self.active)
    animator.setLightActive("flashlightSpread", self.active)
    animator.playSound("flashlight")
  end
  self.lastFireMode = fireMode
end

function zFlashlight:reset()
  animator.setLightActive("flashlight", false)
  animator.setLightActive("flashlightSpread", false)
  self.active = false
end

function zFlashlight:uninit()
  self:reset()
end
