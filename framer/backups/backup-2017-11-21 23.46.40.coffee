Framer.Extras.Hints.disable()

# Variables
gutter = 22
lastItemMaxY = _item.y - 22
lastItem2MaxY = _item2.y

{Firebase} = require 'firebase'
db = new Firebase
	projectID: "smartpen-89fd5"
	secret: "2oAAnqRfOYKhwZ0fQf9eCpTFNb9PR1b4ZvbWanju" 

db.onChange "/dates/", (dates) ->
	datesArray = _.toArray(dates)
	print "onChange" + " size:" + datesArray.length
	for item, index in list
		item.destroy()
	for dataValue, index in datesArray
		#print "dataIndex(" + index + "): " + dateIndex.index
		item = _item.copy()
		item.parent = scroll.content
		item.visible = true
		item.text = dataValue.index
		item.y = lastItemMaxY + gutter
		lastItemMaxY = item.maxY
		
		item.onTap ->
			print this.text	
		
		line = _line.copy()
		line.parent = scroll.content
		line.visible = true	
		line.y = lastItemMaxY + 8
		
###
db.get "/dateIndex/", (dateIndex) ->
	dateIndexArray = _.toArray(dateIndex)
	for dateIndex, index in dateIndexArray
		#print "dataIndex(" + index + "): " + dateIndex.index
		item = _item.copy()
		item.parent = scroll.content
		item.visible = true
		item.text = dateIndex.index
		item.y = lastItemMaxY + gutter
		lastItemMaxY = item.maxY
		
		item.onTap ->
			#print this.text	
		
		line = _line.copy()
		line.parent = scroll.content
		line.visible = true	
		line.y = lastItemMaxY + 4
###		

###	
db.get "/dates/20171106193446/words/31513676", (dates) ->
	menusArray = _.toArray(dates)
	print menusArray
###
	
scroll = ScrollComponent.wrap(list)
scroll.scrollHorizontal = false
scroll.sendToBack()
scroll.content.draggable.momentum = true
scroll.content.draggable.overdrag = false
scroll.content.draggable.bounce = false

scroll2 = ScrollComponent.wrap(list2)
scroll2.scrollHorizontal = false
scroll2.sendToBack()
scroll2.content.draggable.momentum = true
scroll2.content.draggable.overdrag = false
scroll2.content.draggable.bounce = false

###		
menuDB.get "/menu/"+getDate()+"/1식당/점심", (menus) ->
	menusArray = _.toArray(menus)

	if menus is null
		noMenu.opacity = 1.0
	
	dotGroup.visible = false
		
	lastItemMaxY = 0	
	for menuData, index in menusArray
		item = _item_image.copySingle()	
		item.parent = scroll.content
		item.visible = true
		#item.y = index * (item.height + gutter) + 64
		item.y = lastItemMaxY + gutter
		lastItemMaxY = item.maxY
		
		item.onTap ->
			heart.scale = 0.5
							
			changeHeartColor(heart)
		
			animation_cirlces()
			
			Utils.delay 1.0, ->
				heart.animate
					scale: 0.1
					opacity: 0.0
					options:
						time: 0.5
						curve: Bezier.easeInOut
		
		menu = _menu.copySingle()
		menu.parent = item
		menu.text = menuData.menu
		menu.width = item.width * 0.8

		sidemenu = _sidemenu.copySingle()
		sidemenu.parent = item
		sidemenu.text = menuData.description
		sidemenu.maxY = Align.bottom(-8)
		sidemenu.width = item.width * 0.8
	
		restaurant = _restaurant.copySingle()
		restaurant.parent = item
		restaurant.text = menuData.restaurant
					
		menuDB.get "/foods/"+menuData.menu, (foods) ->
			if foods.image
				image = _image.copySingle()
				image.parent = item
				image.image = foods.image
				sidemenu.width = item.width * 0.5
				
		item.animate
			y: index * (item.height + gutter) + 8
			time: 0.5
			options: 
				curve: Spring(damping: 0.3)
				delay: 0.2 * (index + 1)
###



	