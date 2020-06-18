function xcode_template_sync
	set TEMPLATE_PATH ~/Library/Developer/Xcode/Templates/File\ Templates/Clean\ Swift
	cp $TEMPLATE_PATH/Router.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UIViewController/
	cp $TEMPLATE_PATH/Router.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UITableViewController/
	cp $TEMPLATE_PATH/Router.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UICollectionViewController/
	cp $TEMPLATE_PATH/View\ Controller.xctemplate/UIViewController/*.swift $TEMPLATE_PATH/Scene.xctemplate/UIViewController/
	cp $TEMPLATE_PATH/View\ Controller.xctemplate/UITableViewController/*.swift $TEMPLATE_PATH/Scene.xctemplate/UITableViewController/
	cp $TEMPLATE_PATH/View\ Controller.xctemplate/UICollectionViewController/*.swift $TEMPLATE_PATH/Scene.xctemplate/UICollectionViewController/
	cp $TEMPLATE_PATH/Interactor.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UIViewController/
	cp $TEMPLATE_PATH/Interactor.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UITableViewController/
	cp $TEMPLATE_PATH/Interactor.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UICollectionViewController/
	cp $TEMPLATE_PATH/Presenter.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UIViewController/
	cp $TEMPLATE_PATH/Presenter.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UITableViewController/
	cp $TEMPLATE_PATH/Presenter.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UICollectionViewController/
	cp $TEMPLATE_PATH/Worker.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UIViewController/
	cp $TEMPLATE_PATH/Worker.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UITableViewController/
	cp $TEMPLATE_PATH/Worker.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UICollectionViewController/
	cp $TEMPLATE_PATH/Request.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UIViewController/
	cp $TEMPLATE_PATH/Request.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UITableViewController/
	cp $TEMPLATE_PATH/Request.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UICollectionViewController/
	cp $TEMPLATE_PATH/Models.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UIViewController/
	cp $TEMPLATE_PATH/Models.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UITableViewController/
	cp $TEMPLATE_PATH/Models.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UICollectionViewController/
end
