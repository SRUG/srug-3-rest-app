ActionController::Routing::Routes.draw do |map|

  map.resources :users, :has_many => :statuses
  
  map.resources :statuses, :only => [:index, :show]
  
  map.root :controller => "statuses"
  
end
