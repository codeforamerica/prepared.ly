# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([ name: 'Chicago' ,  name: 'Copenhagen' ])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Task.create(:task => "Clean and maintain your gutters", :difficulty => 'Hard',:fact => "Gutters can collect debris, such as branches or leaves, which can catch embers blowing in the wind during a wildfire. If you haven't cleaned the gutters in a while, a few hours with a small shovel (or make your own by cutting a plastic bottle in half). Make sure to work with another person and be careful if you're using a ladder, or take the gutter down.  Use a plumber's snake or hose with pressure nozzle for stubborn clogs. For rain gutters, consider enclosing them to prevent future debris buildup.")

Task.create(:task => "Climb up into your attic and make sure vent screens are clean", :difficulty => 'Medium', :fact => "Cleaning any collected debris from the vents in your attic can prevent sparks from entering your home.  If you don't have screens on your vents, cover exterior attic and underfloor vents with wire screening no larger than 1/8-inch mesh.")

Task.create(:task => "Keep a water supply around your home with hoses or pumps", :difficulty => 'Easy', :fact => "Have multiple garden hoses that are long enough to reach any area of your home and other structures on your property. Have hoses on all four corners of your home to help firefighters defend your home. If you have a pool or well, consider a pump.")

Task.create(:task => "Take an outdoor inventory: do you have wooden shingles on your home?  A wooden fence surrounding your home?  A wooden deck?  Considering adding any of those?", :difficulty => 'Easy', :fact => "Take steps to mitigate risks associated with these structures, which can serve as fuel bridges in certain circumstances.  Use masonry or metal as a protective barrier, consider using firewise roof construction materials, such as Class-A asphalt, metal, slate or others, or add a fire-resistant subroof. Use heavy timber or nonflammable construction material for decks, or make the underside is enclosed with fire-resistant to pre they're covered with fire-resistant materials to prevent embers from blowing underneath.")

Task.create(:task => "Quick yard cleanup - clear baskets, dried flowers and the like from your deck, clear our brush, debris and combustible materials from under your deck, make sure propane tanks are tightly closed, make sure wooden furniture and other miscellaneous objects aren't too close to your home.", :difficulty => 'Hard', :fact => "Keep your deck clear of combustible items, such as baskets, dried flower arrangements and other debris.")

Task.create(:task => "Create a defensible space.", :difficulty => 'Superstar', :fact => "Creating a buffer zone by removing weeds, brush and other vegetation is important, especially if you live near the Wildland Urban Interface. Keep fire and flying embers away from your home. Experts suggest a well-maintained and cleared radius of at least 30 feet (extending up to 200 feet depending on the landscape) immediately around your home should be cleared and maintained.")

Task.create(:task => "Indoor checkup: check your smoke detector batteries, make sure family members know how to use fire extinguishers, and where gas, electric and water shut-offs are (and how to use them!).", :difficulty => 'Easy', :fact => "Take a few minutes, this one's important.")

Task.create(:task => "Fire home tool asses: fire extinguisher, shovel, rake, bucket, ladder",  :difficulty => 'Easy', :fact => "If these items aren't on-site and handy, take a quick trip to the store or order online")

Task.create(:task => "Fill out a brief survey to help us make Prepared.ly better",  :difficulty => 'From the couch', :fact => "Our goal is to make Prepared.ly useful and relevant, and maybe even fun!  We appreciate your feedback.")
