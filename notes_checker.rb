class NotesChecker
	SIGHTREADING = [
		{:note => 48, :duration => 1}, 
		{:note => 48, :duration => 1}, 
		{:note => 55, :duration => 1},
		{:note => 55, :duration => 1},
		{:note => 57, :duration => 1},
		{:note => 57, :duration => 1},
		{:note => 55, :duration => 2}]
	def initialize(sound)
		@sound = sound
	end

	def eval_notes
		array_length = @sound.length - 1

		0.upto(array_length) do |index|
			have_note = @sound.at(index)[:on] != nil
			last_note = @sound.at(index + 1) == nil

			if have_note && !last_note
				on_before = @sound.at(index - 1)[:on].to_f 
			elsif last_note
				on_before = @sound.at(index)[:off].to_f
			else 
				on_before = 0
			end
			
			
			if have_note
					puts (@sound.at(index)[:midi].to_f - SIGHTREADING.at(index)[:note]) / SIGHTREADING.at(index)[:note] < 0.10 ? "Well done! You sang a #{SIGHTREADING.at(index)[:note]}" : "A bit off"
					puts (@sound.at(index)[:on].to_f - on_before) / SIGHTREADING.at(index)[:duration] > 0.90 ? "On time!" : "Wrong time!"
			else puts "missed it!"
			end	
		end
	end
end


x = Notes.new([
	{:midi=>"46.000000", :on=>"1.172608", :off=>"2.449705"}, 
	{:midi=>"48.000000", :on=>"2.449705", :off=>"3.535238"}, 
	{:midi=>"55.000000", :on=>"3.535238", :off=>"4.609161"}, 
	{:midi=>"55.000000", :on=>"4.609161", :off=>"5.706304"}, 
	{:midi=>"57.000000", :on=>"5.706304", :off=>"6.727982"}, 
	{:midi=>"57.000000", :on=>"6.727982", :off=>"7.778685"}, 
	{:midi=>"55.000000", :on=>"7.778685", :off=>"9.241542"}, 
])

x.eval_notes