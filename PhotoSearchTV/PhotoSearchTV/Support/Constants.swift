//
//  Constants.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 21/8/22.
//

import Foundation

struct Constants {

    //FEED API - TAGS 
    //https://api.flickr.com/services/feeds/photos_public.gne?tags=cats&tagmode=any&format=json&jsoncallback=1

    //SEARCH API
    //https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=e9385d4dca3bbdcdf113ea2984dda18e&text=public&format=json&nojsoncallback=1

    //URL IMAGE API
    //https://api.flickr.com/services/feeds/photos_public.gne?tags=cats&tagmode=any&format=json&jsoncallback=1


    static let API_KEY = "e9385d4dca3bbdcdf113ea2984dda18e"
    static let baseUrl = "https://www.flickr.com/"
    static let searchUrl = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=API_KEY&text=SEARCH_TEXT&format=json&nojsoncallback=1"
    static let feedsUrl = "https://api.flickr.com/services/feeds/photos_public.gne?tags=cats&tagmode=any&format=json&nojsoncallback=1"

//    #
//    # Typical usage
//    #
//
//    https://live.staticflickr.com/{server-id}/{id}_{secret}_{size-suffix}.jpg
//
//    #
//    # Unique URL format for 500px size
//    #
//
//    https://live.staticflickr.com/{server-id}/{id}_{secret}.jpg
//
//    #
//    # Originals might have a different file format extension
//    #
//
//    https://live.staticflickr.com/{server-id}/{id}_{o-secret}_o.{o-format}
//
//    #
//    # Example
//    #   server-id: 7372
//    #   photo-id: 12502775644
//    #   secret: acfd415fa7
//    #   size: w
//    #
//
//    https://live.staticflickr.com/7372/12502775644_acfd415fa7_w.jpg

    static let imageUrl = "https://live.staticflickr.com/{SERVER_ID}/{PHOTO_ID}_{SECRET}_w.{FORMAT}"
}
