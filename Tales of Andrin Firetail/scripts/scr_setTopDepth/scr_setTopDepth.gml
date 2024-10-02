function setTopDepth(objId){
	for (var i = 0; i<instance_count; i++){
		try{
			var checkDepth = instance_id_get(i).depth
			if checkDepth < objId.depth{ 
				objId.depth = checkDepth-1
				}
		}catch(e){
			
		}
	}
}