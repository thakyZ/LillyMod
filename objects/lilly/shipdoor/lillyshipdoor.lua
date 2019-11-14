require "/scripts/util.lua"

function init()
  self.detectArea = config.getParameter("detectArea")
  self.detectArea[1] = object.toAbsolutePosition(self.detectArea[1])
  self.detectArea[2] = object.toAbsolutePosition(self.detectArea[2])

  animator.setAnimationState("portal", "off")

  storage.uuid = storage.uuid or sb.makeUuid()
  object.setInteractive(true)
end

function update(dt)
  local players = world.entityQuery(self.detectArea[1], self.detectArea[2], {
      includedTypes = {"player"},
      boundMode = "CollisionArea"
    })

  if #players > 0 and animator.animationState("portal") == "off" then
    animator.setAnimationState("portal", "open")
    animator.playSound("open");
  elseif #players == 0 and animator.animationState("portal") == "on" then
    animator.setAnimationState("portal", "close")
    animator.playSound("close");
  end
end
