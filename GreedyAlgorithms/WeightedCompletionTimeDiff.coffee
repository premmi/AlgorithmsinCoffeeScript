fs = require 'fs',
  _ = require 'lodash'
fs.readFile 'jobs.txt', 'utf-8', (err, data) ->
  fileText = data
  fileText = fileText.split '\n'
  fileText = fileText[1..fileText.length-2]
  fileText = for line in fileText
    splitLine = line.split(" ")
    {
    jobWeight: parseInt(splitLine[0])
    jobLength: parseInt(splitLine[1])
    diff: splitLine[0] - splitLine[1]
    }
  fileText.sort((job1, job2)->
    if job1.diff isnt job2.diff then job1.diff - job2.diff
    else job1.jobWeight - job2.jobWeight
  ).reverse()
  initialObject = {
  jobWeight: '0'
  jobLength: '0'
  diff: 0
  completionTime: 0
  totalCompletionTime: 0
  }
  _.reduce(fileText, (acc, obj, index, coll) ->
    obj.completionTime = acc.completionTime + obj.jobLength
    obj.weightedCompletionTime = obj.jobWeight * obj.completionTime
    obj.totalCompletionTime = acc.totalCompletionTime + obj.weightedCompletionTime
    coll[index]
  , initialObject)

  console.log fileText
