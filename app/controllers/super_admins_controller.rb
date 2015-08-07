class SuperAdminsController < ApplicationController
  
  # There are few things that make me this nervous. Session is not secure, and
  # how will this stress the server? Future replacement, can you do this better?
  # DOC: Allows database-wide searches and filters for active monitoring.
  def crunch
    # If superadmin is logged in. Then define items. Need to also pass in the kind
    # of query that's passed in. 
    @results = Receipt.all
    
    # Issue. need to structure the results table based on query type. Lots of partials.
    # Pass in the type of query. 
  end
end
