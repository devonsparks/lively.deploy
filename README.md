# lively.deploy

This repository explores ways to reduce the deployment footprint of Lively Kernel-based applications. The included Makefile fetches a new copy of Lively Kernel, pruning development tools and research extensions to provide a basic Morphic substrate for restricted end-user applications.

Most of this repository is a stopgap until we find a better way to deploy reduced Lively applications. It's provided as-is with no warranty. Good luck :)

## Usage

1. Place serialized Lively worlds for deployment in src/worlds.
2. Call `make`. This will:
   * Fetch a new copy of Lively from github, installing it in build/LivelyKernel.
   * Prune parts of the core related to interactive development (code browsers, editors, etc).
   * Patch a few modules needing to keep the system from imploding on start.
   * Copy the serialized worlds in src/worlds to the Lively Kernel root directory. 

3. Start Lively with `cd build/LivelyKernel && npm start` or `make start`
4. Open the application at its endpoint (currently served on 9001), e.g., https://localhost:9001/example.html

## Directory Structure

* **src/worlds**: Holds serialized application worlds for deployment.
* **src/apps**: Holds application-specific modules added to deployed world requirements (TOOD).
* **build/**: Holds deployed Lively instance (build/LiveKernel).
* **doc/lively-full.svg**: Visualization of module dependencies in default Lively installation as of LivelyKernel/LivelyKernel commit  095255a.
* **doc/lively-pruned.svg**: Visualization of module dependencies in pruned Lively installation on build produced by this Makefile.
* **doc/livelyModuleGraph.js**: Snippets for generating dot file fragments from a topological sort of module dependencies.


## TODO
* Consider replacing Makefile with npm scripts
* Add support for deployed modules in src/apps.
* Test Windows deployment (easiest if we don't have to build sqlite)
* Consider building an interactive deployment tool that can stream copies of modules and worlds directly into a dynamically created node instance.
* Figure out how to configure boostrap process without resorting to manual flag munging (see Makefile). Probably requires using localconfig.js
* Look at cleaning up muddled dependencies (MenuBar for anonymous modules, why we still need ide.js, references to ace in morphic/Events.js).
* Set flags to turn off all subservers, PartsBin, etc to further speed up loading.

