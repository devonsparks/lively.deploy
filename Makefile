.PHONY: all

all: GetLively PruneCore PatchModules Configure

GetLively:
	git clone https://github.com/LivelyKernel/LivelyKernel

PruneCore:
	rm -rf LivelyKernel/core/apis
	rm -rf LivelyKernel/core/clojure
	rm -rf LivelyKernel/core/lib/ace
	rm -rf LivelyKernel/core/lib/mocha-bundle.js
	rm -rf LivelyKernel/core/lively/ChangeSets.js
	rm -rf LivelyKernel/core/lively/codeeditor/ace.js
	rm -rf LivelyKernel/core/lively/data/AudioUpload.js
	rm -rf LivelyKernel/core/lively/data/DirectoryUpload.js
	rm -rf LivelyKernel/core/lively/data/ODF*
	rm -rf LivelyKernel/core/lively/data/PDFUpload.js
	rm -rf LivelyKernel/core/lively/data/VideoUpload.js
	rm -rf LivelyKernel/core/lively/experimental
	rm -rf LivelyKernel/core/lively/Helper.js
	rm -rf LivelyKernel/core/lively/ide/BrowserFramework.js
	rm -rf LivelyKernel/core/lively/ide/codeeditor
	rm -rf LivelyKernel/core/lively/ide/DirectoryWatcher.js
	rm -rf LivelyKernel/core/lively/ide/ErrorViewer.js
	rm -rf LivelyKernel/core/lively/ide/FileBrowsing.js
	rm -rf LivelyKernel/core/lively/ide/FileParsing.js
	rm -rf LivelyKernel/core/lively/ide/FileSystem.js
	rm -rf LivelyKernel/core/lively/ide/git
	rm -rf LivelyKernel/core/lively/ide/SimpleBrowser.js
	rm -rf LivelyKernel/core/lively/ide/snippets
	rm -rf LivelyKernel/core/lively/ide/SourceDatabase.js
	rm -rf LivelyKernel/core/lively/ide/SyntaxHighlighting.js
	rm -rf LivelyKernel/core/lively/ide/SystemBrowserNodes.js
	rm -rf LivelyKernel/core/lively/ide/SystemCodeBrowserAddons.js
	rm -rf LivelyKernel/core/lively/ide/SystemCodeBrowser.js
	rm -rf LivelyKernel/core/lively/ide/BrowserCommands.js
	rm -rf LivelyKernel/core/lively/ide/CodeEditor.js
	rm -rf LivelyKernel/core/lively/CommandLineInterface.js
	rm -rf LivelyKernel/core/lively/ide/tests
	rm -rf LivelyKernel/core/lively/ide/tools
	rm -rf LivelyKernel/core/lively/ide/WindowNavigation.js
	rm -rf LivelyKernel/core/lively/LayerableMorphs.js
	rm -rf LivelyKernel/core/lively/LogHelper.js
	rm -rf LivelyKernel/core/lively/MochaTests.js
	rm -rf LivelyKernel/core/lively/morphic/EventExperiments.js
	rm -rf LivelyKernel/core/lively/morphic/tools
	rm -rf LivelyKernel/core/lively/net/CloudStorage.js
	rm -rf LivelyKernel/core/lively/net/Dropbox.js
	rm -rf LivelyKernel/core/lively/net/OneDrive.js
	rm -rf LivelyKernel/core/lively/net/tools/Lively2Lively.js
	rm -rf LivelyKernel/core/lively/presentation

PatchModules:

	# Until we figure out how to prevent the bootstrapper from loading an optimized kernel,
	# let's explicitly trip the flag. Yes, this is gross. Let's fix it.
	sed -i "s/combinedModulesHash;/combinedModulesHash = false, optimizedLoading = false;/" LivelyKernel/core/lively/bootstrap.js

	# A few anonymous modules seem to depend on lively.ide, so until we can decouple them,
	# let's keep ide.js but remove its dependent modules.
	sed -i "1cmodule('lively.ide').requires().toRun(function() {" LivelyKernel/core/lively/ide.js;

Configure:

	#cp config.json LivelyKernel/core/lively/localconfig.json
	cp worlds/*.html LivelyKernel
	#cp apps/* LivelyKernel/apps

clean:
	rm -rf LivelyKernel


start:
	cd LivelyKernel && node bin/lk-server.js
