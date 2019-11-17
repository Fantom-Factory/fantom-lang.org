# fantom-lang.org

This is the public repository for the [fantom-lang.org](https://fantom-lang.org/) website.

To suggest documentation updates, simply fork and send a pull request.

The main web pages are located in [etc/web-pages/](etc/web-pages/) as [Slim](http://eggbox.fantomfactory.org/pods/afSlim/) files.



## Running the site locally

To run fantom-lang.org locally, and assuming you have [Fantom](https://fantom-lang.org/download) and [FPM](http://eggbox.fantomfactory.org/pods/afFpm/) installed, then simply run the following:

    # navigate to the git repo
    $ cd <fantom-lang.org git repo>

    # download / update all pod dependencies
    $ fpm update
    
    # build the website
    $ fpm build
    
    # fire it up!
    $ fpm run afFantomLang

Then point your browser at `http://localhost:8069/`.
