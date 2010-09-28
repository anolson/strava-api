require 'helper'
require 'mocha'
require 'json'

class TestHashBasedStore < Test::Unit::TestCase
  
  def setup
    @connection = :placeholder
    @attribute_map = {'name' => :name, 'id' => :id }
    @initial_values = {'id' => 3, 'name' => 'Fred'}
    
    @nested_class_map = { :bike => Strava::Bike }
    @complex_attribute_map = {'name' => :name, 'id' => :id, 'bike' => :bike }
    @complex_initial_values = {'id' => 3, 'name' => 'Fred', 'bike' => {'id' => 7, 'name' => 'Cruiser'}}
  end
  
  def test_creating
    obj = Strava::HashBasedStore.new(@connection, @attribute_map, {}, {})
    
    assert obj.is_a?(Strava::HashBasedStore)
  end
  
  def test_storing_values
    obj = Strava::HashBasedStore.new(@connection, @attribute_map, {}, @initial_values)
    
    assert obj[:id] == @initial_values['id']
    assert obj[:name] == @initial_values['name']
  end

  def test_getting_values_via_methods
    obj = Strava::HashBasedStore.new(@connection, @attribute_map, {}, @initial_values)
    
    assert obj.id == @initial_values['id']
    assert obj.name == @initial_values['name']
  end
  
  def test_create_with_nested_object
    obj = Strava::HashBasedStore.new(@connection, @complex_attribute_map, @nested_class_map, @complex_initial_values)
    
    assert obj[:id] == @complex_initial_values['id']
    assert obj[:name] == @complex_initial_values['name']
    
    assert obj[:bike].is_a?(Strava::Bike)
    assert obj[:bike][:id] == @complex_initial_values['bike']['id']
    assert obj[:bike][:name] == @complex_initial_values['bike']['name']
  end

  def test_create_with_nested_object_via_methods
    obj = Strava::HashBasedStore.new(@connection, @complex_attribute_map, @nested_class_map, @complex_initial_values)
    
    assert obj.id == @complex_initial_values['id']
    assert obj.name == @complex_initial_values['name']
    
    assert obj.bike.is_a?(Strava::Bike)
    assert obj.bike.id == @complex_initial_values['bike']['id']
    assert obj.bike.name == @complex_initial_values['bike']['name']
  end
end
