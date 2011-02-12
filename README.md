# Aviary

Aviary generates a static photo gallery from Twitter hashtags.

Twitter is a fantastic resource for discovering photos of events as they unfold. Searching by hastag means you have to do the filtering. Commentary and relinking drown new and interesting photos. In the days the water rose during the 2011 Brisbane floods I wished there was a way to see all the photos without the noise. Now there is.

See the wiki for a [listing of galleries](https://github.com/tatey/aviary/wiki/galleries).

## Getting Started

Install Aviary at the command prompt if you haven't yet

    gem install aviary
    
At the command prompt, create a new Aviary template

    aviary new bird

Change directory and for search tweets tagged with `bird` that have photos

    cd bird
    aviary search bird
     
Build the static photo gallery

    aviary build

## Dependencies

Ruby 1.9

### Runtime

* Base58
* DataMapper (Core, Migrations and Validations)
* Nokoigir
* Twitter

### Developer

* MiniTest
* Webmock

## Customising the Template

When you create a new aviary you'll notice `_assets/` and `template.erb` are automatically generated for you. Aviary uses these files and directories to generate the static photo gallery. 

Linking back to Aviary is not required, although it is appreciated. 

### template.erb

Pages are plain ERB templates. You get access to the photos and pagination for the current page. You can control the number of photos per page by using `aviary build --per-page=NUM`.

`image_hosts` is a collection of photos for the current page. 

    <% image_hosts.each do |image_host| %>
      <a href="<%= image_host.href %>"><img src="<%= image_host.src %>"></a>
      <p><%= image_host.status.from_user %> said <%= h image_host.status.text %></p>
    <% end >

`paginator` is for finding where you are. 

    <% if paginator.prev_page? %>
      <a href="/page<%= paginator.prev_page %>/">Previous</a>
    <% end %>
    <% if paginator.next_page? %>
      <a href="/page<%= paginator.next_page %>/">Next</a>
    <% end %>

`h` escapes content which may be unsafe, such as a user's status text.

    <%= h "<script>" %>
    
    ...becomes
      
    &lt;script&gt;

### _assets

Anything inside the `_assets` directory is recursively copied into the root of the destination directory. 

Examples:

    ~/bird/_assets/aviary.css -> ~/bird/_site/aviary.css
    ~/bird/_assets/images/status.png -> ~/bird/_site/images/status.png
    
Be careful not to name any of your assets with the following names:
    
* _assets/index.htm
* _assets/page1
* _assets/page2
* ...
* _assets/pageN

## Why the Name?

Aviary is defined as "A large cage for keeping birds in". Replace cage with "photo gallery" and birds with "tweets".

## Copyright

Copyright © 2010 Tate Johnson. Aviary is released under the MIT license. See LICENSE for details.
