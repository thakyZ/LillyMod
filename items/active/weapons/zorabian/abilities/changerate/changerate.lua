require "/scripts/util.lua"
require "/items/active/weapons/weapon.lua"

ChangeRate = WeaponAbility:new()

function ChangeRate:init()
  self.rateIndex = math.min(config.getParameter("rateIndex", 1), #self.rateTypes)
  self:rateChange()

  self.weapon.onLeaveAbility = function()
    self.weapon:setStance(self.stances.idle)
  end
end

function ChangeRate:update(dt, fireMode, shiftHeld)
  WeaponAbility.update(self, dt, fireMode, shiftHeld)

--  if not self.weapon.currentAbility and self.fireMode == (self.activatingFireMode or self.abilitySlot) then
  if not self.weapon.currentAbility and self.fireMode == "alt" then
    self:setState(self.switch)
  end
end

function ChangeRate:switch()
  self.rateIndex = (self.rateIndex % #self.rateTypes) + 1
  activeItem.setInstanceValue("rateIndex", self.rateIndex)

  self:rateChange()
  animator.playSound("switchRate")

  self.weapon:setStance(self.stances.switch)

  util.wait(self.stances.switch.duration)
end

function ChangeRate:rateChange()
  local rate = self.weapon.abilities[self.changedRateIndex]
  util.mergeTable(rate, self.rateTypes[self.rateIndex])
  animator.setAnimationState("rateType", tostring(self.rateIndex))
end

function ChangeRate:uninit()
end
