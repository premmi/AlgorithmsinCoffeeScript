fs = require 'fs'
_ = require 'lodash'
fs.readFile 'edges.txt', 'utf-8', (err, data) ->
  fileText = data
  fileText = fileText.split '\n'
  numVertices = fileText[0].split(' ')[0]
  edges = []
  fileText = fileText[1..fileText.length-2]
  fileText = for line in fileText
    splitLine = line.split(" ")
    {
    vertex1: parseInt(splitLine[0])
    vertex2: parseInt(splitLine[1])
    edgeCost: parseInt(splitLine[2])
    }
  x = [fileText[0].vertex1]
  while x.length < numVertices
    edgesWithMSTVertex = _.filter(fileText, (obj) ->
      (_.contains(x, obj.vertex1) and !_.contains(x, obj.vertex2)) or (!_.contains(x, obj.vertex1) and _.contains(x, obj.vertex2))
    )
    minEdge = _.min(edgesWithMSTVertex, (edge)-> edge.edgeCost)
    edges.push(minEdge.edgeCost)
    x.push(if _.contains(x, minEdge.vertex1) then minEdge.vertex2 else minEdge.vertex1)

  totalCost = _.reduce(edges, (acc, edgeCost) -> acc + edgeCost)
  console.log totalCost








