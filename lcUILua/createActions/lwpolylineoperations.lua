LWPolylineOperations = {}
LWPolylineOperations.__index = LWPolylineOperations

setmetatable(LWPolylineOperations, {
    __index = CreateOperations,
    __call = function (o, ...)
        local self = setmetatable({}, o)
        self:_init(...)
        return self
    end,
})

function LWPolylineOperations:_init(id)
    CreateOperations._init(self, id, lc.builder.LWPolylineBuilder, "enterPoint")
	self.currentVertex = "line"
	self.tempPoint = false
end

function LWPolylineOperations:enterPoint(eventName, data)
	
	if(self.tempPoint) then
		self.builder:removeVertex(-1)
		self.tempPoint = false
	end

	if(eventName == "mouseMove") then
        self:newData(data["position"])
		self.tempPoint = true
	elseif(eventName == "point" or eventName == "number") then
        self:newData(data["position"])
    end
end

function LWPolylineOperations:newData(data)
    if(data ~= nil) then
        if(self.currentVertex == "line") then
			self.builder:addLineVertex(data)
        elseif(self.currentVertex == "arc") then
			self.builder:addArcVertex(data)
        end
    else
		self.builder:modifyLastVertex(data)
    end
end

function LWPolylineOperations:refreshTempEntity()
	if(#self.builder:getVertices() > 1) then
        CreateOperations.refreshTempEntity(self)
    end
end

function LWPolylineOperations:close()
    if(self.tempPoint) then
            self.builder:removeVertex(-1)
            self.tempPoint = false
    end

	if(self.creatingPolyspline == nil) then
        if(#self.builder:getVertices() > 1) then
            self.creatingPolyspline = true
            self:createEntity()
        end
        CreateOperations.close(self)
    end
end

function LWPolylineOperations:createArc()
    self.currentVertex = "arc"

    if(#self.builder:getVertices() > 1) then
		if(self.tempPoint) then
			self.builder:removeVertex(-1)
			self.tempPoint = false
		end

		self.builder:modifyLastVertexArc()
    end

    message("Give arc angle and coordinates", self.target_widget)
end

function LWPolylineOperations:createLine()
    self.currentVertex = "line"

    if(#self.builder:getVertices() > 1) then
		if(self.tempPoint) then
			self.builder:removeVertex(-1)
			self.tempPoint = false
		end

		self.builder:modifyLastVertexLine()
    end

    message("Give line coordinates", self.target_widget)
end
