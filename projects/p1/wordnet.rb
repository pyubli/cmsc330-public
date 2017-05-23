require_relative "graph.rb"

class Synsets
    def initialize
        @s = Hash.new
    end

    def load(synsets_file)
        to_ent = Array.new
        to_out = Array.new
        File.open(synsets_file, "r") do |f|
            f.each_line do |line|
                arr = line.split(' ')
                arr2 = line.chomp.split(/ /)
                if arr2[0] == "id:" && arr2[2] == "synset:" then
                    if arr[1].to_i >= 0 then
                        if @s.has_key?(arr[1].to_i) == false then
                            to_ent << Array[arr[1], arr[3]]
                        end
                    end
                else
                    to_out << arr[1].to_i+1
                end
            end
        end

        if to_out.empty? == true then
            to_ent.each_index { |x| self.addSet(to_ent[x][0].to_i, to_ent[x][1])}
            return nil
        else
            return to_out.to_a
        end
    end

    def addSet(synset_id, nouns)
        if synset_id < 0 || nouns == nil || @s.has_key?(synset_id) == true then
            return false
        else
            @s[synset_id] = nouns
            return true
        end
    end

    def lookup(synset_id)
        if @s.has_key?(synset_id) == false then
            return nil
        else
            print @s.values_at(synset_id).to_s.split(','),"\n"#.split(%r{\[\]\,\"\s*})
            return @s.values_at(synset_id)
        end
    end

    def findSynsets(to_find)
        if to_find.is_a?(String) == true then
            return @s.select { |keys, values| values == to_find}.keys
        elsif to_find.is_a?(Array) == true then
            found = Hash.try_convert(to_find)
            return found.each_key { |key| @s.select { |keys, values| values == key}.keys}
        else
            return nil
        end
    end
end

class Hypernyms
    def initialize
        @h = Array.new
    end

    def load(hypernyms_file)
        raise Exception, "Not implemented"
    end

    def addHypernym(source, destination)
        if source < 0 || destination > 0 || source == destination then
            return false
        else
            return true
        end
    end

    def lca(id1, id2)
        raise Exception, "Not implemented"
    end
end

class CommandParser
    def initialize
        @synsets = Synsets.new
        @hypernyms = Hypernyms.new
    end

    def parse(command)
        raise Exception, "Not implemented"
    end
end
