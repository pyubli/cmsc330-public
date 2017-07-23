require_relative "graph.rb"

class Synsets
    def initialize
        @s = Hash.new
    end

    def load(synsets_file)
        File.open(synsets_file, "r") { |file|
            file.each_line { |line|
                puts line
            }
        }
    end

    def addSet(synset_id, nouns)
        if synset_id < 0 || nouns.empty? == true || @s.has_key?(synset_id) == true then
            return false
        else
            @s.store(synset_id, nouns)
            return true
        end
    end

    def lookup(synset_id)
        raise Exception, "Not implemented"
    end

    def findSynsets(to_find)
        raise Exception, "Not implemented"
    end
end

class Hypernyms
    def initialize
        @h = Graph.new
    end

    def load(hypernyms_file)
        raise Exception, "Not implemented"
    end

    def addHypernym(source, destination)
        raise Exception, "Not implemented"
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
