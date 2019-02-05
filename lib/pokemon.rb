class Pokemon

  attr_accessor :id, :name, :type, :db, :hp
  # attr_reader :id, :name, :type, :db

  # def initialize(attr)
  #   @hp = 60
  #   attr.each { |k,v| self.send("#{k}=", v) }
  # end
  def initialize(attr)
    attr["hp"].nil? ? @hp = 60 : @hp = attr["hp"]

    @id = attr["id"]
    @name = attr["name"]
    @type = attr["type"]
    @db = attr["db"]
  end

  def alter_hp(hp, db)
    @hp = hp
    db.execute("UPDATE pokemon SET hp = #{hp} WHERE id = #{@id}")
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES ('#{name}', '#{type}')")
    # binding.pry
  end


  def self.find(id, db)
    db.results_as_hash = true
    data = db.execute("SELECT * FROM pokemon WHERE id = #{id}").first
    data["db"] = db
    # Pokemon.new(id: data[0]["id"], name: data[0]["name"], type: data[0]["type"], db: db)
    Pokemon.new(data)
    # binding.pry
  end

end
