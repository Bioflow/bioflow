# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#item = WorkflowItem.new(name:"Temporary", summary:"Summary", totalinputs:0, totaloutputs:1, category:"Input", isparent:false, parent:"root", itemid:"temporary")

item=WorkflowItem.new()
item.name="Temporary"
item.summary="Summary"
item.totalinputs=1
item.totaloutputs=1
item.category="Input"
item.isparent=false
item.itemid="temporary"
item.save()
=begin
WorkflowItem.new(name:"FASTA", summary:"Summary", totalinputs:1, totaloutputs:1, category:"Mapping", isparent:false, parent:"root", itemid:"fasta_mapper")

WorkflowItem.new(name:"BamFile", summary:"bamFile", totalinputs:1, totaloutputs:1, category:"Mapping", isparent:false, parent:"root", itemid:"input_bamfile")

WorkflowItem.new(name:"SamToolsSort", summary:"Summary", totalinputs:1, totaloutputs:1, category:"Mapping", isparent:false, parent:"root", itemid:"samtools_sort")

WorkflowItem.new(name:"BamFile", summary:"bamFile", totalinputs:1, totaloutputs:1, category:"Input", isparent:false, parent:"root", itemid:"input_bamfile")


bam_file = BamFile.new("temporaryBamFile")
t.string   "job_id"
    t.string   "work_obj"
    t.string   "input_ids"
    t.string   "output_ids"
Job.new(work_obj: bam_file, input_ids:[1,2,3], output_ids:[1,2],job_id:"job_1")
=end
