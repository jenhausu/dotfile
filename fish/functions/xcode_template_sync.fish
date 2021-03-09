function xcode_template_sync
	set TEMPLATE_PATH ~/Library/Developer/Xcode/Templates/File\ Templates/Clean\ Swift

	# UIViewController
	cp $TEMPLATE_PATH/Router.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UIViewController/
    cp $TEMPLATE_PATH/View\ Controller.xctemplate/UIViewController/*.swift $TEMPLATE_PATH/Scene.xctemplate/UIViewController/
    cp $TEMPLATE_PATH/Interactor.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UIViewController/
    cp $TEMPLATE_PATH/Presenter.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UIViewController/
    cp $TEMPLATE_PATH/Worker.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UIViewController/
    cp $TEMPLATE_PATH/Request.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UIViewController/
    cp $TEMPLATE_PATH/Models.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UIViewController/

	# UITableViewController
    cp $TEMPLATE_PATH/Router.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UITableViewController/
    cp $TEMPLATE_PATH/View\ Controller.xctemplate/UITableViewController/*.swift $TEMPLATE_PATH/Scene.xctemplate/UITableViewController/
    cp $TEMPLATE_PATH/Interactor.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UITableViewController/
    cp $TEMPLATE_PATH/Presenter.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UITableViewController/
    cp $TEMPLATE_PATH/Worker.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UITableViewController/
    cp $TEMPLATE_PATH/Request.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UITableViewController/
    cp $TEMPLATE_PATH/Models.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UITableViewController/
    cp $TEMPLATE_PATH/TableViewCell.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UITableViewController/

	# UICollectionViewController
    cp $TEMPLATE_PATH/Router.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UICollectionViewController/
    cp $TEMPLATE_PATH/View\ Controller.xctemplate/UICollectionViewController/*.swift $TEMPLATE_PATH/Scene.xctemplate/UICollectionViewController/
    cp $TEMPLATE_PATH/Interactor.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UICollectionViewController/
    cp $TEMPLATE_PATH/Presenter.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UICollectionViewController/
    cp $TEMPLATE_PATH/Worker.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UICollectionViewController/
    cp $TEMPLATE_PATH/Request.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UICollectionViewController/
    cp $TEMPLATE_PATH/Models.xctemplate/*.swift $TEMPLATE_PATH/Scene.xctemplate/UICollectionViewController/


    if test $argv[1] = "push"
        cp -r ~/Library/Developer/Xcode/Templates/File\ Templates/ ~/Documents/repository/XcodeTemplate-VIP/
	end

	if test $argv[1] = "pull"
        cp -r ~/Documents/repository/XcodeTemplate-VIP/ ~/Library/Developer/Xcode/Templates/File\ Templates/
    end
end
