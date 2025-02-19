require_relative 'test_helper'

describe "Trip class" do
  before do
    start_time = Time.parse('2015-05-20T12:14:00+00:00')
    end_time = start_time + 25 * 60 # 25 minutes
    @trip_data = {
      id: 8,
      passenger: RideShare::Passenger.new(id: 1,
        name: "Ada",
        phone_number: "412-432-7640"
      ),
      driver: RideShare::Driver.new(
        id: 54,
        name: "Rogers Bartell IV",
        vin: "1C9EVBRM0YBC564DZ"
      ),
      start_time: start_time,
      end_time: end_time,
      cost: 23.45,
      rating: 3
    }
    
    @trip = RideShare::Trip.new(@trip_data)
  end
  
  describe "initialize" do
    it "is an instance of Trip" do
      expect(@trip).must_be_kind_of RideShare::Trip
    end
    
    it "stores start_time and end_time as instances of Time" do
      expect(@trip.start_time).must_be_kind_of Time
      expect(@trip.end_time).must_be_kind_of Time
    end
    
    it "raises an ArgumentError if end_time is before start_time" do
      start_time = Time.parse('2015-05-20T12:14:00+00:00')
      end_time = start_time - 25 * 60 # 25 minutes
      trip_data = {
        id: 8,
        passenger: RideShare::Passenger.new(id: 1,
          name: "Ada",
          phone_number: "412-432-7640"
        ),
        driver: RideShare::Driver.new(
          id: 54,
          name: "Rogers Bartell IV",
          vin: "1C9EVBRM0YBC564DZ"
        ),
        start_time: start_time,
        end_time: end_time,
        cost: 23.45,
        rating: 3
      }
      
      expect do
        RideShare::Trip.new(trip_data)
      end.must_raise ArgumentError
    end
    
    it "stores an instance of passenger" do
      expect(@trip.passenger).must_be_kind_of RideShare::Passenger
    end
    
    it "stores an instance of driver" do
      expect(@trip.driver).must_be_kind_of RideShare::Driver
    end
    
    it "raises an error for an invalid rating" do
      [-3, 0, 6].each do |rating|
        @trip_data[:rating] = rating
        expect do
          RideShare::Trip.new(@trip_data)
        end.must_raise ArgumentError
      end
    end
  end
  
  describe "duration method" do
    it "returns the duration of the trip in seconds" do
      expect(@trip.duration).must_equal 25 * 60
    end
  end
end
