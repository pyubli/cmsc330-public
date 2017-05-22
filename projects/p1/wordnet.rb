require_relative "graph.rb"

class Synsets
    def initialize
        @s = Hash.new
    end

    def load(synsets_file)
        File.open(synsets_file, "r") do |f|
            f.each_line do |line|
                puts line
            end
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
