class RandomHash < Hash
  def initialize
    @ds = Hash.new
  end

  def children
    array = Array.new
    rand(1..3).times do
      array << Faker::Name.first_name
    end
    array
  end

  def has_kids?
    rand(2) == 1
  end

  def hash_one
    hash = Hash.new
    10.times do
      name = Faker::Company.name
      bs = Faker::Company.bs
      hash[name] = bs
    end
    hash
  end

  def hash_two
    hash = Hash.new
    10.times do
      email = Faker::Internet.email
      num = rand(1..1000)
      hash[email] = num
    end
    hash
  end

  def hash_three
    hash = Hash.new
    length = rand(1..5)
    count = 1
    while count <= length
      details = Hash.new
      name = Faker::Name.name
      phone = Faker::PhoneNumber.cell_phone
      company = Faker::Company.name
      details["phone"] = phone
      details["company"] = company
      details["children"] = children if has_kids?
      hash[name] = details
      count += 1
    end
    hash
  end

  # def nested_hash(levels)
  #   return nil if levels <= 0
  #   array = nested_hash(levels - 1)
  #   name = Faker::Name.first_name
  #   { name => array.nil? ? rand(1..100) : [array] }
  # end

  def generate
    pick = rand(1..3)
    case pick
    when 1
      @ds = hash_one
    when 2
      @ds = hash_two
    when 3
      @ds = hash_three
    end
    @ds
  end

end
